<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <h2>
 <%
 String headermessage=(String) request.getAttribute("headermessage");
 if(headermessage!=null)
 {
 	out.print(headermessage);
 }
 
 %>
 
 </h2>
<p>
<%

String err=(String) request.getAttribute("SessionMessage");
if(err!=null)
{
	out.print(err);
}

%>
</p>