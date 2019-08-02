
<!DOCTYPE HTML>

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2016 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../Common/EnvironmentSetup.jspf" %>
<%@ include file="../../Common/nocache.jspf" %>

<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>    
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../include/ErrorMessageSetup.jspf" %>

<c:set var="myAccountPage" value="true" scope="request"/>
<fmt:message bundle="${storeText}" key="MYACCOUNT_ORDER_APPROVAL" var="contentPageName" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="false" scope="request"/>
<c:set var="pageCategory" value="MyAccount" scope="request"/>

<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
	xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<%@ include file="../../Common/CommonCSSToInclude.jspf"%>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><fmt:message key="MYACCOUNT_ORDER_APPROVAL" bundle="${storeText}"/></title>

		<!-- Include script files -->
		<%@ include file="../../Common/CommonJSToInclude.jspf"%>
	</head>
	
	<body>
		<!-- Page Start -->
		<div id="page" class="nonRWDPageB">
			<%@ include file="../../Common/CommonJSPFToInclude.jspf"%>	
			
			<!-- Header Widget -->
			<div id="headerWrapper">
				<%out.flush();%>
				<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp" />
				<%out.flush();%>
			</div>

			<!-- Main Content Start -->
			<div id="contentWrapper">
				<div id="content" role="main">
					<div class="rowContainer" id="container_reqList_detail">
						<div class="row margin-true">
							<!-- breadcrumb -->
							<%out.flush();%>
								<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">  
									<wcpgl:param name="pageGroup" value="Content" />
									<wcpgl:param name="doNotCacheForMyAccount" value="true"/>
								</wcpgl:widgetImport>
							<%out.flush();%>	
							<div class="col12"></div>
						</div>
						<div class="row margin-true">
							<!-- Left Nav -->
							<%-- <div class="col4 acol12 ccol3">
								<%out.flush();%>
								
									Since this is OrderApprovalDisplay page, OrderApprovalList widget included below will fetch the count. 
									Ignore fetching pending approval count in MyAccountNavigation.jsp 
								
								<c:set var="fetchPendingOrderApprovalCount" value="false" scope="request"/>
								<c:set var="updateCountInJS" value="true" scope="request"/>
								<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.MyAccountNavigation/MyAccountNavigation.jsp"/>
								<%out.flush();%>	
							</div> --%>
							
							<!-- Content area -->
							<div class="col12 acol12 ccol12 right">	
								<div id="mainContent_OrderApprovalList" role="main" aria-label="<fmt:message key="MYACCOUNT_APPROVAL_REQUESTS" bundle="${storeText}"/>" aria-expanded="true">	
									<div id="OrderAporovalPageHeading">						
										<h1><fmt:message key="MYACCOUNT_ORDER_APPROVAL" bundle="${storeText}"/></h1>
									</div>	
								<div class="row headInsideMenu">
									<div class="col1">&nbsp;</div>
									<div class="col10 userIconLine">
										<div class="ordersApproveUserIcon"> </div>
										<hr>
									</div>
									<div class="col1">&nbsp;</div>
									<div class="col12"><p>Orders to Approve</p></div>
									<div class="col12 links">
										<div class="normalMenu" id="accDetailMenu">
											<%out.flush();%>
										        <c:import url="${env_jspStoreDir}Common/MyAccountPageURLs.jsp"/>
										    <%out.flush();%>
										</div>
									</div>
								</div>
									<%out.flush();%>
									<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrderApprovalList/OrderApprovalList.jsp">			
										<wcpgl:param name="storeId" value="${storeId}" />
										<wcpgl:param name="catalogId" value="${catalogId}" />
										<wcpgl:param name="langId" value="${langId}" />
										<wcpgl:param name="approvalStatus" value="0"/> <%-- By default display Pending approvals --%>
									</wcpgl:widgetImport>			
									<%out.flush();%>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>				
			<!-- Main Content End -->

			<!-- Footer Widget -->
			<div id="footerWrapper">
				<%out.flush();%>
				<c:import url="${env_jspStoreDir}Widgets/Footer/Footer.jsp"/>
				<%out.flush();%>
			</div>
		
		</div>
		<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
		<%@ include file="../../Common/JSPFExtToInclude.jspf"%>
	</body>
</html>
