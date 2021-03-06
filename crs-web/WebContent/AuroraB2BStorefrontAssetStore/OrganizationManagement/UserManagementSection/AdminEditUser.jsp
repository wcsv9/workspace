
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../Common/EnvironmentSetup.jspf" %>
<%@ include file="../../Common/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>    
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../include/ErrorMessageSetup.jspf" %>

<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="addtionalBCT" scope="request"><fmt:message bundle="${storeText}" key="ORGANIZATIONMANAGE_ORGS_AND_USERS"/></c:set>
<wcf:url var="additionalBCT_URL" value="OrganizationsAndUsersView" scope="request">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>
<c:set var="pageCategory" value="MyAccount" scope="request"/>
<c:set var="memberId" value=""/>
<c:if test="${not empty WCParam.memberId }" >
	<c:set var="memberId" value="${WCParam.memberId}" />
</c:if>
<c:if test="${empty memberDataInitialized }" >
	<c:set var="memberDataInitialized" value="true" scope="request"/>
	<wcf:rest var="memberDetails" url="store/{storeId}/person/{memberId}" scope="request">
		<wcf:var name="storeId" value="${storeId}" encode="true"/>
		<wcf:var name="memberId" value="${memberId}" encode="true"/>
		<wcf:param name="responseFormat" value="json" />
		<wcf:param name="profileName" value="IBM_User_Registration_Details"/>
	</wcf:rest>
</c:if>

<%-- Display the name of the buyers according to locale --%>
<c:choose>
	<c:when test="${locale eq 'ja_JP' || locale eq 'ko_KR' || locale eq 'zh_CN' || locale eq 'zh_TW'}">
		<c:set var="userName" value="${memberDetails.address.lastName} ${memberDetails.address.firstName}"/>
	</c:when>
	<c:otherwise>
		<c:set var="userName" value="${memberDetails.address.firstName} ${memberDetails.address.lastName}"/>
	</c:otherwise>
</c:choose>
<c:set var="contentPageName" scope="request">${userName}</c:set>

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

<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
	xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<%@ include file="../../Common/CommonCSSToInclude.jspf"%>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><wcf:out value='${contentPageName}'/></title>

		<!-- Include script files -->
		<%@ include file="../../Common/CommonJSToInclude.jspf"%>

		<script type="text/javascript">  
		$(document).ready(function() {
			widgetCommonJS.initializeEditSectionToggleEvent();
			<fmt:message key="ORGANIZATIONUSERINFO_UPDATE_SUCCESS" bundle="${storeText}" var="ORGANIZATIONUSERINFO_UPDATE_SUCCESS"/>
			MessageHelper.setMessage("ORGANIZATIONUSERINFO_UPDATE_SUCCESS","<c:out value='${ORGANIZATIONUSERINFO_UPDATE_SUCCESS}'/>");
			
			MessageHelper.setMessage("PWDREENTER_DO_NOT_MATCH", Utils.getLocalizationMessage('PWDREENTER_DO_NOT_MATCH'));
			MessageHelper.setMessage("WISHLIST_INVALIDEMAILFORMAT", Utils.getLocalizationMessage('WISHLIST_INVALIDEMAILFORMAT'));
			MessageHelper.setMessage("ERROR_INVALIDPHONE", Utils.getLocalizationMessage('ERROR_INVALIDPHONE'));
			MessageHelper.setMessage("ERROR_LastNameEmpty", Utils.getLocalizationMessage('ERROR_LastNameEmpty'));
			MessageHelper.setMessage("ERROR_AddressEmpty", Utils.getLocalizationMessage('ERROR_AddressEmpty'));
			MessageHelper.setMessage("ERROR_CityEmpty", Utils.getLocalizationMessage('ERROR_CityEmpty'));
			MessageHelper.setMessage("ERROR_StateEmpty", Utils.getLocalizationMessage('ERROR_StateEmpty'));
			MessageHelper.setMessage("ERROR_CountryEmpty", Utils.getLocalizationMessage('ERROR_CountryEmpty'));
			MessageHelper.setMessage("ERROR_ZipCodeEmpty", Utils.getLocalizationMessage('ERROR_ZipCodeEmpty'));
			MessageHelper.setMessage("ERROR_EmailEmpty", Utils.getLocalizationMessage('ERROR_EmailEmpty'));
			MessageHelper.setMessage("ERROR_LogonIdEmpty", Utils.getLocalizationMessage('ERROR_LogonIdEmpty'));
			MessageHelper.setMessage("ERROR_PasswordEmpty", Utils.getLocalizationMessage('ERROR_PasswordEmpty'));
			MessageHelper.setMessage("ERROR_VerifyPasswordEmpty", Utils.getLocalizationMessage('ERROR_VerifyPasswordEmpty'));
			MessageHelper.setMessage("ERROR_INVALIDEMAILFORMAT", Utils.getLocalizationMessage('ERROR_INVALIDEMAILFORMAT'));
			MessageHelper.setMessage("ERROR_FirstNameEmpty", Utils.getLocalizationMessage('ERROR_FirstNameEmpty'));
			MessageHelper.setMessage("ERROR_FirstNameTooLong", Utils.getLocalizationMessage('ERROR_FirstNameTooLong'));
			MessageHelper.setMessage("ERROR_LastNameTooLong", Utils.getLocalizationMessage('ERROR_LastNameTooLong'));
			MessageHelper.setMessage("ERROR_AddressTooLong", Utils.getLocalizationMessage('ERROR_AddressTooLong'));
			MessageHelper.setMessage("ERROR_CityTooLong", Utils.getLocalizationMessage('ERROR_CityTooLong'));
			MessageHelper.setMessage("ERROR_StateTooLong", Utils.getLocalizationMessage('ERROR_StateTooLong'));
			MessageHelper.setMessage("ERROR_CountryTooLong", Utils.getLocalizationMessage('ERROR_CountryTooLong'));
			MessageHelper.setMessage("ERROR_ZipCodeTooLong", Utils.getLocalizationMessage('ERROR_ZipCodeTooLong'));
			MessageHelper.setMessage("ERROR_EmailTooLong", Utils.getLocalizationMessage('ERROR_EmailTooLong'));
			MessageHelper.setMessage("ERROR_PhoneTooLong", Utils.getLocalizationMessage('ERROR_PhoneTooLong'));
			MessageHelper.setMessage("ERROR_SpecifyYear", Utils.getLocalizationMessage('ERROR_SpecifyYear'));
			MessageHelper.setMessage("ERROR_SpecifyMonth", Utils.getLocalizationMessage('ERROR_SpecifyMonth'));
			MessageHelper.setMessage("ERROR_SpecifyDate", Utils.getLocalizationMessage('ERROR_SpecifyDate'));
			MessageHelper.setMessage("ERROR_InvalidDate1", Utils.getLocalizationMessage('ERROR_InvalidDate1'));
			MessageHelper.setMessage("ERROR_InvalidDate2", Utils.getLocalizationMessage('ERROR_InvalidDate2'));
			MessageHelper.setMessage("AGE_WARNING_ALERT", Utils.getLocalizationMessage('AGE_WARNING_ALERT'));
			MessageHelper.setMessage("ERROR_OrgNameEmpty", Utils.getLocalizationMessage('ERROR_OrgNameEmpty'));
		});
	</script>
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
			<div id="EditBuyerErrorMessage">
				<c:if test="${!empty errorMessage}">
					<script type="text/javascript">
						$(document).ready(function() {
							MessageHelper.displayErrorMessage('${errorMessage}');
						});
					</script>
				</c:if>
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
							<div class="col4 acol12 ccol3">
								<%out.flush();%>
								<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.MyAccountNavigation/MyAccountNavigation.jsp"/>
								<%out.flush();%>	
							</div>
							
							<!-- Content area -->
							<div class="col8 acol12 ccol9 right">
								<div id="BuyerAdministratorBuyerCommonPageHeading" >
									<h1><wcf:out value='${contentPageName}'/></h1>
								</div>
								<%out.flush();%>
								<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.UserOrganizationDetails/UserOrganizationDetails.jsp">
									<wcpgl:param name="fromPage" value="editUser" />
								</wcpgl:widgetImport>
								<%out.flush();%>
								<%out.flush();%>
								<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrganizationUserInfo/OrganizationUserInfo.jsp">
									<wcpgl:param name="fromPage" value="editUser" />
								</wcpgl:widgetImport>
								<%out.flush();%>

								<c:if test = "${(env_shopOnBehalfSessionEstablished eq 'false' && env_shopOnBehalfEnabled_CSR eq 'false')}">
									<%-- This is a normal buyerAdmin session or buyerAdmin on-behalf-session for another buyerAdmin. Not a CSR session --%>
									<%out.flush();%>
									<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.UserRoleManagement/UserRoleManagement.jsp">
										<wcpgl:param name="fromPage" value="editUser" />
									</wcpgl:widgetImport>
									<%out.flush();%>
									<%out.flush();%>
									<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.UserMemberGroupManagement/UserMemberGroupManagement.jsp">
										<wcpgl:param name="fromPage" value="editUser" />
									</wcpgl:widgetImport>
									<%out.flush();%>
									<%-- Include this for role assignment confirmation popup dialog --%>
									<%@ include file="../../Common/ConfirmationPopup.jspf"%>
								</c:if>
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
		<div id="overlay" class="nodisplay"></div>
	</body>
</html>
