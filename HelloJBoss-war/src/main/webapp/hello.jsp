<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<html>
<head>
  <title>Hello JBoss</title>
</head>  
<body>
  <f:view>
  <h:form id="helloForm" >
  <h2>Hi. I'm a JSF app.</h2>
  <h:commandButton id="submit" action="greeting" value="Hello ..." /> 
 </h:form>
</f:view>
</html>
