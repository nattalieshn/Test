<%--
  Created by IntelliJ IDEA.
  User: nattalie
  Date: 4/10/2018 AD
  Time: 00:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "com.mysql.jdbc.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<sql:query dataSource="jdbc/test" var="result">
    SELECT * FROM customers
</sql:query>

<sql:query dataSource="jdbc/test" var="customers">
    SELECT * FROM customers WHERE id = ?
    <sql:param value="${param.id}" />
</sql:query>

<!DOCTYPE html>
<!--update-->
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer</title>
</head>
<body>
<h1>Product <c:out value="${param.id}"/></h1>
<c:forEach var="p" items="${customers.rows}">
    <form action="product-controller">
        <input type="hidden" name="cmd" value="u"/>
        <input type="hidden" name="id" value='<c:out value="${p.id}"/>'/>
        <table>
            <tr>
                <td>Firstname</td>
                <td><input type="text" name="first_name" value='<c:out value="${p.first_name}"/>'></td>
            </tr>
            <tr>
                <td>Lastname</td>
                <td><input type="text" name="last_name" value='<c:out value="${p.last_name}"/>'></td>
            </tr>
            <tr>
                <td>Email</td>
                <td><input type="text" name="email_address" value='<c:out value="${p.email_address}"/>'></td>
            </tr>
            <!--<tr>
                <td>Category</td>
                <td>

                    <select name="category_id">
                        <c:forEach var="row" items="${result.rows}">
                            <option value='<c:out value="${row.id}"/>'
                                    <c:if test = "${row.id} == ${p.category_id}">
                                        SELECTED
                                    </c:if>
                            >
                                <c:out value="${row.name}"/>
                                <c:out value="${row.id}"/>
                                <c:out value="${p.category_id}"/>
                                <c:if test = "${row.id} == ${p.category_id}">
                                    SELECTED
                                </c:if>
                            </option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>-->
                <td colspan="2">
                    <input type="submit" value="Update">
                </td>
            </tr>
        </table>
    </form>
</c:forEach>

</body>
</html>