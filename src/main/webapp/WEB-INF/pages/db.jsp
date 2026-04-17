<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Database Users | Pulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <style>
        .db-container {
            max-width: 1000px;
            margin: 100px auto;
            padding: 40px;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        h1 {
            color: #fff;
            margin-bottom: 30px;
            font-size: 2.5rem;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            color: #ddd;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        th {
            color: #fff;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 1px;
        }
    </style>
</head>
<body>
    <div class="db-container">
        <h1>User Database</h1>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Password</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<String[]> users = (List<String[]>) request.getAttribute("userList");
                    if (users != null && !users.isEmpty()) {
                        for (String[] user : users) {
                %>
                <tr>
                    <td><%= user[0] %></td>
                    <td><%= user[1] %></td>
                    <td><%= user[2] %></td>
                    <td>••••••••</td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="4" style="text-align: center;">No users found in the database.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <div style="margin-top: 30px; text-align: center;">
            <a href="dashboard" style="color: #3b82f6; text-decoration: none;">&larr; Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
