

DECLARE @html NVARCHAR(MAX);

SET @html = N'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Index Metadata</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f9;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        td {
            word-wrap: break-word;
            max-width: 300px;
        }
        @media screen and (max-width: 600px) {
            table {
                font-size: 14px;
            }
            th, td {
                padding: 8px;
            }
        }
    </style>
</head>
<body>
    <h1>Index Metadata</h1>
    <table>
        <thead>
            <tr>
                <th>Table Name</th>
                <th>Index Name</th>
                <th>Index Type</th>
                <th>Key Column Types</th>
                <th>Included Column Types</th>
            </tr>
        </thead>
        <tbody>';

-- Append rows from query
SELECT @html = @html + '
            <tr>
                <td>' + ISNULL(CAST(t.name AS NVARCHAR(MAX)), '') + '</td>
                <td>' + ISNULL(CAST(i.name AS NVARCHAR(MAX)), 'Heap') + '</td>
                <td>' + ISNULL(CAST(i.type_desc AS NVARCHAR(MAX)), '') + '</td>
                <td>' + ISNULL(STRING_AGG(
                    CASE 
                        WHEN ic.is_included_column = 0 THEN CAST(c.name + ' (' + ty.name + 
                            CASE 
                                WHEN ty.name IN ('char', 'varchar', 'nchar', 'nvarchar') THEN '(' + 
                                    CASE WHEN c.max_length = -1 THEN 'MAX' ELSE CAST(c.max_length AS NVARCHAR(10)) END + ')'
                                WHEN ty.name IN ('decimal', 'numeric') THEN '(' + CAST(c.precision AS NVARCHAR(10)) + ',' + CAST(c.scale AS NVARCHAR(10)) + ')'
                                ELSE ''
                            END + ')' AS NVARCHAR(MAX))
                        ELSE NULL 
                    END, ', '), 'None') + '</td>
                <td>' + ISNULL(STRING_AGG(
                    CASE 
                        WHEN ic.is_included_column = 1 THEN CAST(c.name + ' (' + ty.name + 
                            CASE 
                                WHEN ty.name IN ('char', 'varchar', 'nchar', 'nvarchar') THEN '(' + 
                                    CASE WHEN c.max_length = -1 THEN 'MAX' ELSE CAST(c.max_length AS NVARCHAR(10)) END + ')'
                                WHEN ty.name IN ('decimal', 'numeric') THEN '(' + CAST(c.precision AS NVARCHAR(10)) + ',' + CAST(c.scale AS NVARCHAR(10)) + ')'
                                ELSE ''
                            END + ')' AS NVARCHAR(MAX))
                        ELSE NULL 
                    END, ', '), 'None') + '</td>
            </tr>'
FROM sys.indexes i
INNER JOIN sys.tables t ON i.object_id = t.object_id
LEFT JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
LEFT JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
LEFT JOIN sys.types ty ON c.user_type_id = ty.user_type_id
WHERE i.is_hypothetical = 0
GROUP BY t.name, i.name, i.type_desc;

-- Close HTML tags
SET @html = @html + '
        </tbody>
    </table>
</body>
</html>';



exec msdb.dbo.sp_send_dbmail
	@profile_name = 'NewProfile',
	@recipients = 'sayfiyevs65@gmail.com',
	@subject = 'This is test from sql server',
	@body = @html