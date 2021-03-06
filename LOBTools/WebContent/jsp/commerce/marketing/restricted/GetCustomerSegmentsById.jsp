<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@page contentType="text/xml;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>
<wcf:getData
	type="com.ibm.commerce.member.facade.datatypes.MemberGroupType[]"
	var="memberGroups" expressionBuilder="findByUniqueIDs" varShowVerb="showVerb">
	<wcf:contextData name="storeId" data="${param.storeId}" />
	<wcf:param name="accessProfile" value="IBM_Summary" />
	<c:forTokens var="value" items="${uniqueIDs}" delims=",">
		<wcf:param name="UniqueID" value="${value}" />
	</c:forTokens>
</wcf:getData>
<c:forEach var="group" items="${memberGroups}">
	<c:set var="showVerb" value="${showVerb}" scope="request"/>
	<c:set var="businessObject" value="${group}" scope="request"/>
	<c:choose>
		<c:when test="${group.memberGroupIdentifier.externalIdentifier.storeIdentifier.uniqueID != param.storeId}">
			<c:set var="referenceObjectType" value="ChildInheritedCustomerSegment" />
		</c:when>
		<c:otherwise>
			<c:set var="referenceObjectType" value="ChildCustomerSegment" />
		</c:otherwise>
	</c:choose>
	
	<object objectType="${referenceObjectType}">
		<childCustomerSegmentId>${group.memberGroupIdentifier.uniqueID}</childCustomerSegmentId>
		<jsp:directive.include file="SerializeCustomerSegment.jspf" />
	</object>
</c:forEach>
