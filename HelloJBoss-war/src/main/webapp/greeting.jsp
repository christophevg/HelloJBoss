<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<html>
<head>
  <title>Hello JBoss Greeting Page</title>
</head>    
<body>
  <f:view>
  <h3><h:outputText value="#{GreeterBean.greeting}"/></h3>
</f:view>
</body>	
</html>
