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

<%--
  *****
  * This JSP file is used to render the shipping and billing page of the online checkout flow.
  * It allows shoppers to enter their shipping address and shipping method as well as other
  * advanced shipping options such as shipping instructions, requested shipping date, etc.
  * It also allows the shoppers to enter the billing and payment information for their order.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../Common/nocache.jspf"%>

<c:set var="pageCategory" value="Checkout" scope="request"/>

<c:set var="isSinglePageCheckout" value="true"/>
<%-- Check if its a traditional checkout..--%>
<flow:ifDisabled feature="SharedShippingBillingPage"> 
	   <c:set var="isSinglePageCheckout" value="false"/>
</flow:ifDisabled>

<!-- BEGIN OrderShippingBillingDetails.jsp -->
<html xmlns="http://www.w3.org/1999/xhtml"
xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<%@ include file="../../Common/CommonCSSToInclude.jspf"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>
	<flow:ifEnabled feature="SharedShippingBillingPage">
		<c:out value="${storeName}"/> - <fmt:message bundle="${storeText}" key="TITLE_SHIPMENT_DISPLAY"/>
	</flow:ifEnabled>
	<flow:ifDisabled feature="SharedShippingBillingPage">
		<c:out value="${storeName}"/> - <fmt:message bundle="${storeText}" key="TITLE_SHIPMENT_DISPLAY_SHIPPING_ONLY"/>
	</flow:ifDisabled>
</title>

<%-- Tealeaf should be set up before coremetrics inside CommonJSToInclude.jspf --%>
<script type="text/javascript" src="${jsAssetsDir}javascript/Tealeaf/tealeafWC.js"></script>
<c:if test="${env_Tealeaf eq 'true' && env_inPreview != 'true'}">
	<script type="text/javascript" src="${jsAssetsDir}javascript/Tealeaf/tealeaf.js"></script>
</c:if>

<%@ include file="../../Common/CommonJSToInclude.jspf"%>

<c:set var="validAddressId" value=""/>

<c:set var="pageSize" value="${WCParam.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
</c:if>

<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>

<fmt:formatNumber var="currentPage" value="${(beginIndex/pageSize)+1}"/>
<fmt:parseNumber var="currentPage" value="${currentPage}" integerOnly="true"/>

<c:set var="order" value="${requestScope.orderInCart}" />

<flow:ifEnabled feature="Analytics">
	<c:if test="${userType == 'R' && WCParam.showRegTag == 'T'}">
		<script type="text/JavaScript">
			$(document).ready(function() { analyticsJS.publishShopCartLoginTags(); });
		</script>
	</c:if>
</flow:ifEnabled>

<c:if test="${empty order || order==null}">
	<wcf:rest var="order" url="store/{storeId}/cart/@self" scope="request">
		<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
		<wcf:param name="pageSize" value="${pageSize}"/>
		<wcf:param name="pageNumber" value="${currentPage}"/>
		<wcf:param name="sortOrderItemBy" value="orderItemID"/>
	</wcf:rest>
	<c:set var="shippingInfo" value="${order}"/>
</c:if>


<c:if test="${empty order.orderItem && beginIndex >= pageSize}">
	<c:set var="beginIndex" value="${beginIndex - pageSize}" />
	<wcf:rest var="order" url="store/{storeId}/cart/@self" scope="request">
		<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
		<wcf:param name="pageSize" value="${pageSize}"/>
		<wcf:param name="pageNumber" value="${currentPage}"/>
		<wcf:param name="sortOrderItemBy" value="orderItemID"/>
	</wcf:rest>
	<c:set var="shippingInfo" value="${order}"/>
</c:if>

<c:if test="${beginIndex == 0}">
	<fmt:parseNumber var="numEntries" value="${order.recordSetTotal}" integerOnly="true" />
	<c:if test="${numEntries > order.recordSetCount}">
		<c:set var="pageSize" value="${order.recordSetCount}" />
	</c:if>
</c:if>	

<c:set var="orderInCart" value="${requestScope.orderInCart}" />
<c:if test="${empty orderInCart || orderInCart==null}">
	<c:set var="orderInCart" value="${order}" scope="request"/>
	<c:set var="shippingInfoInCart" value="${shippingInfo}" scope="request"/>
	<c:if test="${empty orderInCart || orderInCart==null}">
		<wcf:rest var="orderInCart" url="store/{storeId}/cart/@self" scope="request">
			<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
			<wcf:param name="pageSize" value="${maxOrderItemsToInspect}"/>
			<wcf:param name="pageNumber" value="1"/>
			<wcf:param name="sortOrderItemBy" value="orderItemID"/>
		</wcf:rest>
	</c:if>
	<c:if test="${empty shippingInfoInCart || shippingInfoInCart == null}">
		<c:set var="shippingInfoInCart" value="${orderInCart}"/>
	</c:if>
</c:if>

<c:if test="${!empty shippingInfo.orderItem}">

	<c:set var="forceShipmentType" value=""/>
	<c:if test="${!empty param.forceShipmentType}">
		<c:set var="forceShipmentType" value="${param.forceShipmentType}"/>
	</c:if>
	<c:if test="${!empty WCParam.forceShipmentType}">
		<c:set var="forceShipmentType" value="${WCParam.forceShipmentType}"/>
	</c:if>

	<flow:ifDisabled  feature="MultipleShipments">
		<c:set var="forceShipmentType" value="1"/>
	</flow:ifDisabled>

	<fmt:parseNumber var="numEntries" value="${shippingInfo.recordSetTotal}" integerOnly="true" />
	<c:choose>
		<c:when test="${forceShipmentType == 1}">
			<c:set var="shipmentTypeId" value="1"/>
		</c:when>
		<c:when test="${forceShipmentType == 2}">
			<c:set var="shipmentTypeId" value="2"/>
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${numEntries > maxOrderItemsToInspect}">
					<c:set var="shipmentTypeId" value="2"/>
				</c:when>
				<c:otherwise>
					<jsp:useBean id="blockMap" class="java.util.HashMap" scope="request"/>
					<c:forEach var="orderItem" items="${shippingInfoInCart.orderItem}" varStatus="status">
						<c:set var="itemId" value="${orderItem.orderItemId}"/>
						<c:set var="addressId" value="${orderItem.addressId}"/>
						<c:set var="shipModeId" value="${orderItem.shipModeId}"/>
						<c:set var="requestedShipDate" value="${orderItem.requestedShipDate}"/>
						<c:set var = "keyVar" value="${addressId}_${shipModeId}_${requestedShipDate}"/>
						<c:set var = "itemIds" value="${blockMap[keyVar]}"/>
						<c:choose>
							<c:when test="${empty itemIds}">
								<c:set target="${blockMap}" property="${keyVar}" value="${itemId}"/>
							</c:when>       
							<c:otherwise>
								<c:set target="${blockMap}" property="${keyVar}" value="${itemIds},${itemId}"/>
							</c:otherwise>       
						</c:choose>       
					</c:forEach>
					<c:choose>
						<c:when test = "${fn:length(blockMap) == 1}">
							<c:set var="shipmentTypeId" value="1"/>
						</c:when>
						<c:otherwise>
							<c:set var="shipmentTypeId" value="2"/>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>
</c:if>
			
<c:choose>
	<c:when test="${env_contractSelection || shipmentTypeId == 2}">
		<c:set var="maxItems" value="${pageSize}"/>
	</c:when>
	<c:otherwise>
		<c:set var="maxItems" value="1"/>
	</c:otherwise>
</c:choose>



<%-- The below getdata statment for UsableShippingInfo can be removed if the order services can return order details and shipping details in same service call --%>
<wcf:rest var="orderUsableShipping" url="store/{storeId}/cart/@self/usable_shipping_info" scope="request">
	<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
	<wcf:param name="orderId" value="${order.orderId}"/>
	<wcf:param name="pageSize" value="${pageSize}"/>
	<wcf:param name="pageNumber" value="${currentPage}"/>
</wcf:rest>
<%-- Cache it for future use in same request. --%>
<c:set var="key1" value="store/${storeId}/cart/@self/usable_shipping_info"/>
<wcf:set target = "${cachedUsableShippingInfoMap}" key="${key1}" value="${orderUsableShipping}"/>

<%-- Since this is the online shopping checkout path, we must make sure that none of the order items are using the 'PickUpInStore' shipping mode. --%>
<c:if test="${!empty shippingInfoInCart.orderItem}" >
	<c:set var="invalidShipModeIdForOnline" value="false"/>
	<c:forEach var="orderItem" items="${shippingInfoInCart.orderItem}" varStatus="status">
		<c:if test="${!invalidShipModeIdForOnline}">
			<c:if test="${orderItem.shipModeCode == 'PickupInStore'}">
				<c:set var="invalidShipModeIdForOnline" value="true"/>
			</c:if>
		</c:if>
	</c:forEach>
	<flow:ifDisabled feature="MultipleShipments">
		<c:if test="${!invalidShipModeIdForOnline}">
			<c:set var="validOnlineShipmodeId" value="${shippingInfoInCart.orderItem[0].shipModeId}"/>
			<c:forEach var="orderItem" items="${orderInCart.orderItem}" varStatus="status">
				<c:if test="${!invalidShipModeIdForOnline}">
					<c:set var ="shipModeId" value="${orderItem.shipModeId}"/>
					<c:if test="${validOnlineShipmodeId != shipModeId}">
						<c:set var="invalidShipModeIdForOnline" value="true"/>
					</c:if>
				</c:if>
			</c:forEach>		
		</c:if>
	</flow:ifDisabled>	
</c:if>

<c:if test="${empty validOnlineShipmodeId}">
	<%-- Determine a valid online shipping mode identifier if required --%>
	<c:set var="doneLoop" value="false"/>
	<c:forEach items="${orderUsableShipping.orderItem}" var="curOrderItem">
		<c:if test="${not doneLoop}">
			<c:forEach items="${curOrderItem.usableShippingMode}" var="curShipmode">
				<c:if test="${not doneLoop}">
					<c:if test="${curShipmode.shipModeCode != 'PickupInStore'}">
						<c:set var="doneLoop" value="true"/>
						<c:set var="validOnlineShipmodeId" value="${curShipmode.shipModeId}"/>
					</c:if>
				</c:if>
			</c:forEach>
		</c:if>
	</c:forEach>
</c:if>

<flow:ifDisabled feature="MultipleShipments">
	<c:if test="${!empty shippingInfoInCart.orderItem}" >
		<c:set var="invalidRequestedShipDate" value="false"/>
		<c:set var="currentRequestedShipDate" value="${shippingInfoInCart.orderItem[0].requestedShipDate}"/>
		<c:forEach var="orderItem" items="${shippingInfoInCart.orderItem}" varStatus="status">
			<c:if test="${!invalidRequestedShipDate}">
				<c:set var ="reqShipDate" value="${orderItem.requestedShipDate}"/>
				<c:if test="${currentRequestedShipDate != reqShipDate}">
					<c:set var="invalidRequestedShipDate" value="true"/>
				</c:if>
			</c:if>
		</c:forEach>
	</c:if>
</flow:ifDisabled>	

<c:forEach var="usableAddress" items="${orderUsableShipping.usableShippingAddress}">
	<c:if test="${!empty usableAddress.nickName && usableAddress.nickName != profileBillingNickname}" >
		<c:set var="validAddressId" value="true"/>
	</c:if>
</c:forEach>

<%-- Check to see if all the order items have valid addressId or not. If the addressId of order items is empty, then we
need to first assign a valid address id to these order items before proceeding with the checkout flow. --%>
<c:if test="${!empty shippingInfo.orderItem}" >
	<c:set var="orderItemsHaveInvalidAddressId" value="false"/>
	<%-- Get the list of order items which have an empty addressId.--%>
	<c:forEach var="orderItem" items="${shippingInfo.orderItem}" varStatus="status">
		<c:if test="${!orderItemsHaveInvalidAddressId}">
			<c:set var="addressId" value="${orderItem.addressId}"/>
			<c:if test="${addressId == null || empty addressId}">
				<c:set var="orderItemsHaveInvalidAddressId" value="true"/>
			</c:if>
		</c:if>
	</c:forEach>
	<flow:ifDisabled feature="MultipleShipments">
		<c:if test="${!orderItemsHaveInvalidAddressId}">
			<c:set var="currentAddressId" value="${shippingInfo.orderItem[0].addressId}"/>
			<c:forEach var="orderItem" items="${shippingInfo.orderItem}" varStatus="status">
				<c:if test="${!orderItemsHaveInvalidAddressId}">
					<c:set var="addressId" value="${orderItem.addressId}"/>
					<c:if test="${currentAddressId != addressId}">
						<c:set var="orderItemsHaveInvalidAddressId" value="true"/>
					</c:if>
				</c:if>
			</c:forEach>		
		</c:if>
	</flow:ifDisabled>	
</c:if>

<wcf:url var="ShippingAddressDisplayURL" value="ShippingAddressDisplayView" type="Ajax">
	<wcf:param name="langId" value="${langId}" />                                          
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="forceShipmentType" value="1" />
</wcf:url>

<wcf:url var="ShoppingCartURL" value="RESTOrderCalculate" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="URL" value="AjaxCheckoutDisplayView" />
	<wcf:param name="errorViewName" value="AjaxCheckoutDisplayView" />
	<wcf:param name="updatePrices" value="1" />
	<wcf:param name="calculationUsageId" value="-1" />
	<wcf:param name="orderId" value="." />
</wcf:url>

<wcf:url var="TraditionalShippingURL" value="OrderShippingBillingView" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="forceShipmentType" value="${WCParam.forceShipmentType}" />
</wcf:url>

<wcf:url var="AjaxSingleShipmentShipChargeViewURL" value="AjaxSingleShipmentShipChargeView" type="Ajax">
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}"/>
	<wcf:param name="orderId" value="${order.orderId}"/>
</wcf:url>

<wcf:url var="AjaxMultipleShipmentShipChargeViewURL" value="AjaxMultipleShipmentShipChargeView" type="Ajax" scope="request">
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}"/>
	<wcf:param name="orderId" value="${order.orderId}"/>
</wcf:url>

<%-- This declares the common error messages and <c:url tags --%>
<c:set var="currentOrderId" value="${order.orderId}" />
<%@ include file="CommonUtilities.jspf"%>

<%-- get the addressId --%>
<c:set var="selectedAddressId" value="${shippingInfo.orderItem[0].addressId}"/>
<%-- do we need to ship all items at once.. is it shipAsComplete...--%>
<c:set var="shipAsCompleteCheckBoxStatus" value="false"/>
<c:if test="${order.shipAsComplete}">
	<c:set var="shipAsCompleteCheckBoxStatus" value="true"/>
</c:if>

<%-- Include controllers declarations after common contexts declarations. controllers will make a local copy of the render contexts.. so render contexts should be declared before controllers. Never declare two contexts with same id.. Even if two contexts with same id is defined, they should be defined before defining controller..Because if you declare context and controller in this order..
{context - controller - context} the controller will make a local copy of the first context declared and always refers to it.. But updateContext and other functions will refer to second context declared and so there wont be any sync between context used in code and context referred by controller..Controllers use context by value and not by reference.. --%>
<c:set var="orderPrepare" value="${param.orderPrepare}"/>
<script type="text/javascript">
	$(document).ready(function() { 
		
		
		
		<flow:ifEnabled feature="ShippingChargeType">
			SBControllersDeclarationJS.setShipChargeEnabled('true');
			SBControllersDeclarationJS.setRefreshURL('WC_SingleShipmentDisplay_ShipCharge_Area','<c:out value="${AjaxSingleShipmentShipChargeViewURL}"/>');
		</flow:ifEnabled>
		CheckoutHelperJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
		CheckoutHelperJS.setSinglePageCheckout(<c:out value='${isSinglePageCheckout}'/>);
		CheckoutPayments.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
		ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
		SBServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
		SBServicesDeclarationJS.orderPrepare='<c:out value='${orderPrepare}'/>';
		SBServicesDeclarationJS.setSinglePageCheckout(<c:out value='${isSinglePageCheckout}'/>);
		CommonContextsJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
		SBControllersDeclarationJS.setSinglePageCheckout(<c:out value='${isSinglePageCheckout}'/>);
		SBControllersDeclarationJS.setRefreshURL('WC_ShipmentDisplay_div_17','<c:out value="${TraditionalAjaxShippingDetailsViewURL}"/>');
		SBControllersDeclarationJS.setRefreshURL('shippingAddressSelectBoxArea','<c:out value="${ShippingAddressDisplayURL}"/>');
		SBControllersDeclarationJS.setRefreshURL('WC_ShipmentDisplay_div_18','<c:out value="${AjaxCurrentOrderInformationViewURL}"/>');
		CommonContextsJS.setContextProperty('billingAddressDropDownBoxContext','billingURL1','${billingAddressDisplayURL_1}');
		CommonContextsJS.setContextProperty('billingAddressDropDownBoxContext','billingURL2','${billingAddressDisplayURL_2}');
		CommonContextsJS.setContextProperty('billingAddressDropDownBoxContext','billingURL3','${billingAddressDisplayURL_3}');
		
		/*
			CheckoutPayments.setNumberOfPaymentMethods(1,document.getElementById('numberOfPaymentMethods'),'paymentSection');
			CheckoutPayments.reinitializePaymentObjects(document.getElementById('numberOfPaymentMethods'));
			
			var minChargeApply=document.getElementById('minChargeApply').value;
			var minimumCharges=document.getElementById('minimumCharges').value;
			var minimumValue=document.getElementById('minimumValue').value;
			
			if(minChargeApply=='true' && minimumCharges != '0.0'){
				minimumCharges = minimumCharges/1;
				minimumValue = minimumValue/1;
				minimumCharges = minimumCharges.toFixed(2);
				minimumValue = minimumValue.toFixed(2);
				alert("Your order is below our minimum value for free delivery, and will incur a $"+minimumCharges+" freight charge.\nYou can remove this fee simply by adding additional items to your cart so the value exceeds $"+minimumValue+".\nIf your delivery is out of the Metro area a freight fee may apply, customer service will contact you on this.");
				//document.getElementById('piAmount_1_display').value=document.getElementById('oTotalAmout').value;
				//document.getElementById('piAmount_1').value=document.getElementById('oTotalAmout').value;
				
				CheckoutPayments.getTotalInJSON();
			}*/
			
		
		<fmt:message bundle="${storeText}" key="ERROR_UPDATE_FIRST" var="ERROR_UPDATE_FIRST"/>
		<fmt:message bundle="${storeText}" key="SHOPCART_ADDED" var="SHOPCART_ADDED"/>
		<fmt:message bundle="${storeText}" key="SHOPCART_REMOVEITEM" var="SHOPCART_REMOVEITEM"/>
		<fmt:message bundle="${storeText}" key="SHIPPING_INVALID_ADDRESS" var="SHIPPING_INVALID_ADDRESS"/>
		<fmt:message bundle="${storeText}" key="ERROR_QUICKCHECKOUT_ADDRESS_CHANGE" var="ERROR_QUICKCHECKOUT_ADDRESS_CHANGE"/>
		<fmt:message bundle="${storeText}" key="REQUESTED_SHIPPING_DATE_OUT_OF_RANGE_ERROR" var="REQUESTED_SHIPPING_DATE_OUT_OF_RANGE_ERROR"/>
		<fmt:message bundle="${storeText}" key="ERROR_ShippingInstructions_TooLong" var="ERROR_ShippingInstructions_TooLong"/>
		<fmt:message bundle="${storeText}" key="PAST_DATE_ERROR" var="PAST_DATE_ERROR"/>
		<fmt:message bundle="${storeText}" key="SCHEDULE_ORDER_MISSING_START_DATE" var="SCHEDULE_ORDER_MISSING_START_DATE"/>
		<fmt:message bundle="${storeText}" key="SCHEDULE_ORDER_MISSING_FREQUENCY" var="SCHEDULE_ORDER_MISSING_FREQUENCY"/>
		<%-- Missing --%> 
		<fmt:message bundle="${storeText}" key="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" var="ERROR_CONTRACT_EXPIRED_GOTO_ORDER"/>
		<fmt:message bundle="${storeText}" key="GENERICERR_MAINTEXT" var="ERROR_RETRIEVE_PRICE">                                     
			<fmt:param><fmt:message bundle="${storeText}" key="GENERICERR_CONTACT_US"/></fmt:param>
		</fmt:message>
		<fmt:message bundle="${storeText}" key="SHIP_REQUESTED_ERROR" var="SHIP_REQUESTED_ERROR"/>
		
		<%-- Missing --%>
		<fmt:message bundle="${storeText}" key="ERROR_SWITCH_SINGLE_SHIPMENT" var="ERROR_SWITCH_SINGLE_SHIPMENT"/>
		
		MessageHelper.setMessage("ERROR_RETRIEVE_PRICE", <wcf:json object="${ERROR_RETRIEVE_PRICE}"/>);
		MessageHelper.setMessage("ERROR_UPDATE_FIRST", <wcf:json object="${ERROR_UPDATE_FIRST}"/>);
		MessageHelper.setMessage("SHOPCART_ADDED", <wcf:json object="${SHOPCART_ADDED}"/>);
		MessageHelper.setMessage("SHOPCART_REMOVEITEM",  <wcf:json object="${SHOPCART_REMOVEITEM}"/>);
		MessageHelper.setMessage("SHIPPING_INVALID_ADDRESS", <wcf:json object="${SHIPPING_INVALID_ADDRESS}"/>);
		MessageHelper.setMessage("ERROR_QUICKCHECKOUT_ADDRESS_CHANGE", <wcf:json object="${ERROR_QUICKCHECKOUT_ADDRESS_CHANGE}"/>);
		MessageHelper.setMessage("REQUESTED_SHIPPING_DATE_OUT_OF_RANGE_ERROR", <wcf:json object="${REQUESTED_SHIPPING_DATE_OUT_OF_RANGE_ERROR}"/>);
		MessageHelper.setMessage("ERROR_ShippingInstructions_TooLong", <wcf:json object="${ERROR_ShippingInstructions_TooLong}"/>);		
		MessageHelper.setMessage("PAST_DATE_ERROR", <wcf:json object="${PAST_DATE_ERROR}"/>);
		MessageHelper.setMessage("SCHEDULE_ORDER_MISSING_START_DATE", <wcf:json object="${SCHEDULE_ORDER_MISSING_START_DATE}"/>);
		MessageHelper.setMessage("SCHEDULE_ORDER_MISSING_FREQUENCY", <wcf:json object="${SCHEDULE_ORDER_MISSING_FREQUENCY}"/>);
		MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);
		MessageHelper.setMessage("ERROR_SWITCH_SINGLE_SHIPMENT", <wcf:json object="${ERROR_SWITCH_SINGLE_SHIPMENT}"/>);
		MessageHelper.setMessage("SHIP_REQUESTED_ERROR", <wcf:json object="${SHIP_REQUESTED_ERROR}"/>);
	}); 

	function ShowHideItem(icon, bodyName){
		//alert(icon+bodyName);
		$("."+bodyName).toggle(300);
		if($("."+icon).html()=="+"){
			$("."+icon).html("-");
		}
		else{
			$("."+icon).html("+");
		}
		
	}
</script>
</head>
<body>
<%-- TODO to show quick info for products in the shopping cart
<%@ include file="../../Snippets/ReusableObjects/CatalogEntryQuickInfoDetails.jspf" %>--%>
<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}Common/QuickInfo/QuickInfoPopup.jsp"/>

<%@ include file="../../Snippets/ReusableObjects/GiftItemInfoDetailsDisplayExt.jspf" %>
<%@ include file="../../Snippets/ReusableObjects/GiftRegistryGiftItemInfoDetailsDisplayExt.jspf" %>

<input type="hidden" name="orderId1" id="orderId1" value="${order.orderId}" />
<input type="hidden" name="userType1" id="userType1" value="${userType}" />
<input type="hidden" name="addressListForMailNotification" id="addressListForMailNotification" value="${addressListForMailNotification}" />
<%-- 
	To decide whether to display shipping and billing section or not.
	If current order is locked then just a message is displayed to shopper instead of displaying shipping/billing info.
--%>
<%@ include file="../ShopcartSection/ShopCartOnBehalfOfLock_Data.jspf"%>

<!-- Page Start -->
	<div id="page" >
		<div id="grayOut"></div>
		<%-- This file includes the progressBar mark-up and success/error message display markup --%>
		<%@ include file="../../Common/CommonJSPFToInclude.jspf"%>

		<!-- Import Header Widget -->
		<div class="header_wrapper_position" id="headerWidget">
			<%out.flush();%>
			<c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp" />
			<%out.flush();%>
		</div>
		
		<div id="OrderShippingBillingErrorArea" class="nodisplay" role="alert" aria-describedby="WC_OrderShippingBillingDetails_div_3">
			<div id="WC_OrderShippingBillingDetails_div_1">
				<div class="body" id="WC_OrderShippingBillingDetails_div_2">
					<div class="left" id="WC_OrderShippingBillingDetails_div_3">
						<fmt:message bundle="${storeText}" key="SHIP_PROBLEM_DESC"/>
					</div>
					<br clear="all" />
					<div class="button_align" id="WC_OrderShippingBillingDetails_div_4">
						<a role="button" class="button_primary tlignore" id="WC_OrderShippingBillingDetails_links_1" tabindex="0" href="javascript:setPageLocation('<c:out value='${ShoppingCartURL}'/>')">
							<div class="left_border"></div>
							<div class="button_text"><fmt:message bundle="${storeText}" key="SHIP_GO_BACK"/><span class="spanacce"><fmt:message bundle="${storeText}" key="Checkout_ACCE_back_shopping_cart"/></span></div>
							<div class="right_border"></div>
						</a>
					</div>
				</div>
			</div>
		</div>

		<c:choose>     
			<c:when test = "${empty order.orderItem || (currentOrderLocked == 'true' && currentOrderStatus_CSR != 'locked')}">
				<%-- If empty order OR (order is locked, but not locked by current CSR ) then display empty page with appropriate message --%>
				<div class="content_wrapper_position" role="main">
					<div class="content_wrapper">
						<div class="content_left_shadow">
							<div class="content_right_shadow">
								<div class="main_content">
									<div class="container_full_width">
										<flow:ifEnabled feature="SharedShippingBillingPage">
											<!-- Breadcrumb Start -->
											<div id="checkout_crumb">
												<div class="crumb" id="WC_ShipmentDisplay_div_4">
													<a href="<c:out value="${ShoppingCartURL}"/>" id="WC_ShipmentDisplay_links_2">
														<span class="step_off"><fmt:message bundle="${storeText}" key="BCT_SHOPPING_CART"/></span>
													</a> 
													<span class="step_arrow"></span>
	
													<%--
														If validAddressId is empty, this means there are no common addresses. In Madison, users will be asked to entered addresses. 
														In Elite, since address can be set in the contracts already, we'll skip the address page and go directly to the multiple 
														shipment page if there are no common addresses. If there is a common address, the single shipment page willbe displayed.
													--%>
													<c:choose>
														<c:when test="${empty validAddressId}">
															<c:if test="${(!env_contractSelection && orderItemsHaveInvalidAddressId) || (env_contractSelection && WCParam.guestChkout == '1' )}">
																<span class="step_on"><fmt:message bundle="${storeText}" key="BCT_ADDRESS"/></span>
																<span class="step_arrow"></span>
															</c:if>
															<c:set var="highlightShippingBilling" value="step_off"/>
															<c:if test="${env_contractSelection && !(WCParam.guestChkout == '1')}"><c:set var="highlightShippingBilling" value="step_on"/></c:if>
															<span class="${highlightShippingBilling}" ><fmt:message bundle="${storeText}" key="BCT_SHIPPING_AND_BILLING"/></span>
															<span class="step_arrow"></span>
														</c:when>
														<c:otherwise>
															<span class="step_on"><fmt:message bundle="${storeText}" key="BCT_SHIPPING_AND_BILLING"/></span>
															<span class="step_arrow"></span>
														</c:otherwise>					
													</c:choose>
													<span class="step_off"><fmt:message bundle="${storeText}" key="BCT_ORDER_SUMMARY"/></span>
												</div>
											</div>
											<!-- Breadcrumb End -->
										</flow:ifEnabled>
	
										<flow:ifDisabled feature="SharedShippingBillingPage">
											<div id="checkout_crumb">
												<div class="crumb" id="WC_ShipmentDisplay_div_4">
													<a href="<c:out value="${ShoppingCartURL}"/>" id="WC_ShipmentDisplay_links_2">
														<span class="step_off"><fmt:message bundle="${storeText}" key="BCT_SHOPPING_CART"/></span>
													</a>
													<span class="step_arrow"></span>
													<c:if test="${empty validAddressId}">
														<span class="step_on"><fmt:message bundle="${storeText}" key="BCT_ADDRESS"/></span>
														<span class="step_arrow"></span>
														<span class="step_off"><fmt:message bundle="${storeText}" key="TRA_SHIPPING"/></span>
														<span class="step_arrow"></span>
														<span class="step_off"><fmt:message bundle="${storeText}" key="TRA_BILLING"/></span>
														<span class="step_arrow"></span>
													</c:if>
													<c:if test="${!empty validAddressId}">
														<span class="step_on"><fmt:message bundle="${storeText}" key="BCT_SHIPPING"/></span></a>
														<span class="step_arrow"></span>
														<span class="step_off"><fmt:message bundle="${storeText}" key="BCT_BILLING"/></span>
														<span class="step_arrow"></span>
													</c:if> 
													<span class="step_off"><fmt:message bundle="${storeText}" key="BCT_ORDER_SUMMARY"/></span>
												</div>
											</div>
										</flow:ifDisabled>

										<%-- Display Empty Shopping Cart --%>				
										<div id="box"  class="orderShippingBillPageEmpty">
											<div class="myaccount_header" id="WC_UnregisteredCheckout_div_5">
												<%@ include file="../../Snippets/ReusableObjects/CheckoutTopESpotDisplay.jspf"%>
											</div>
													   
											<div class="body" id="WC_UnregisteredCheckout_div_9">
												<c:if test = "${currentOrderLocked == 'true'}">
													<c:choose>
														<c:when test="${currentOrderStatus_CSR == 'unLocked'}">
															<fmt:message bundle="${storeText}" key='CURRENTORDER_LOCKED' var="emptyCartMessage"/>
														</c:when>
														<c:when test="${currentOrderStatus_CSR == 'takeOver'}">
															<fmt:message bundle="${storeText}" key='TAKE_OVER_ORDER_MESSAGE' var="emptyCartMessage">
																<fmt:param value="${lockedBy}"/>
															</fmt:message>
														</c:when>
													</c:choose>
												</c:if>
												<%@ include file="../../Snippets/ReusableObjects/EmptyShopCartDisplay.jspf"%> 
											</div>
											<div class="footer" id="WC_EmptyShopCartDisplay_div_10">
												<div class="left_corner" id="WC_EmptyShopCartDisplay_div_11"></div>
												<div class="left" id="WC_EmptyShopCartDisplay_div_12"></div>
												<div class="right_corner" id="WC_EmptyShopCartDisplay_div_13"></div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:when>
			<c:when test="${empty validAddressId && ((!env_contractSelection && orderItemsHaveInvalidAddressId) || (env_contractSelection && WCParam.guestChkout == '1'))}" >

				<c:if test="${order.x_isPersonalAddressesAllowedForShipping}">                  
					<%-- User has items in shopping cart but doesnt have any valid address Id.. Redirect user to unregistered address create page first --%>
					<c:import url="/${sdb.jspStoreDir}/ShoppingArea/CheckoutSection/UnregisteredCheckout.jsp"/>                     
				</c:if>
			</c:when>
			<c:when test="${invalidShipModeIdForOnline}" >

				<%-- User has order items with 'PickUpInStore' shipping mode in the online checkout path, those need to be changed to use valid online shipping method --%>
				<%out.flush();%>
				<c:import url="/${sdb.jspStoreDir}/ShoppingArea/CheckoutSection/ShoppingCartItemsUpdateHelper.jsp">
					<c:param value="${validOnlineShipmodeId}" name="shipModeId"/>
				</c:import>
				<%out.flush();%>
			</c:when>
			<c:when test="${orderItemsHaveInvalidAddressId}" >

				<%-- User has some valid shipping addresses, but the order has some order items which do not have an addressId associated with them.
					We need to make one server call to update the addressId of those items which have empty addressId. --%>
				<c:import url="/${sdb.jspStoreDir}/ShoppingArea/CheckoutSection/ShoppingCartItemsUpdateHelper.jsp"/>
			</c:when>
			<c:when test="${invalidRequestedShipDate}" >
				<%-- User has order items with different requested ship dates --%>
				<%out.flush();%>
				<c:import url="/${sdb.jspStoreDir}/ShoppingArea/CheckoutSection/ShoppingCartItemsUpdateHelper.jsp">
					<c:param value="${currentRequestedShipDate}" name="requestedShipDate"/>
				</c:import>
				<%out.flush();%>
			</c:when>			
			<c:otherwise>

				<c:set var="usablePaymentInfo" value="${requestScope.usablePaymentInfo}"/>
				<c:if test="${empty usablePaymentInfo || usablePaymentInfo == null}">
					<wcf:rest var="usablePaymentInfo" url="store/{storeId}/cart/@self/usable_payment_info" scope="request">
						<wcf:var name="storeId" value="${WCParam.storeId}"/>
						<wcf:param name="orderId" value="${order.orderId}"/>
					</wcf:rest>
				</c:if>	

				<c:set var="paymentInstruction" value="${orderInCart}"/>

				<c:set var="totalExistingPaymentMethods" value="1"/>
				<c:forEach var="paymentInstance" items="${paymentInstruction.paymentInstruction}" varStatus="paymentCount">
					<c:set var="totalExistingPaymentMethods" value="${paymentCount.count}"/>
				</c:forEach>

				<c:set var="quickCheckoutProfileForPayment" value="${param.quickCheckoutProfileForPayment}"/>
				<c:if test="${empty quickCheckoutProfileForPayment}">
					<c:set var="quickCheckoutProfileForPayment" value="${WCParam.quickCheckoutProfileForPayment}"/>
				</c:if>

				<c:if test="${quickCheckoutProfileForPayment}">
					<%-- we should use quick checkout profile for payment options..with quick checkout there will be only one payment method --%>
					<c:set var="totalExistingPaymentMethods" value="1"/>
				</c:if>

				<script type="text/javascript">
					// declareEditShippingAdddressAreaController defined in ShippingAndBillingControllersDeclaration.js uses this variable
					var shipmentTypeId = '${shipmentTypeId}';
				</script>

				<div id="content_wrapper" class="content_wrapper_position" wcType="RefreshArea" widgetId="content_wrapper" declareFunction="declareControllerForMainAndAddressDiv()" role="main">
					<div class="content_wrapper">
						<div class="content_left_shadow">
							<div class="content_right_shadow">
							<!-- Content Start -->
							<!-- There are two parts in the content (editAddressContents and mainContents Div)..One Div contains the entire checkoutContents (shopping cart, shipping address, billing info and other things.. The second DIV contains only edit Address page .. On click of Edit Address button, the first div will be hidden and edit address page div will be displayed...
								Instead of having both the div's in same page, we can make a call to server on click of edit button and get the edit Address page..But the problem in that case is, if user clicks on Cancel/Submit button after changing the address details, we update the server with the changes and again redirect the user to Shipping and Billing address page which results in resetting any changes made in shipping / billing details. User will loose all the changes made in shipping/billing page before clicking on edit address button..To avoid this situation we have both the DIV's defined in this page and use hide/show logic here..-->
								<div class="main_content" style="display:block">
									<div class="container_full_width">
									<flow:ifEnabled feature="SharedShippingBillingPage">
										<!-- Breadcrumb Start -->
										<div id="checkout_crumb">
											<div class="crumb" id="WC_ShipmentDisplay_div_4">
												<c:if test = "${!empty order.orderItem}">
													<a href="<c:out value="${ShoppingCartURL}"/>" id="WC_ShipmentDisplay_links_2">
														<span class="step_off"><fmt:message bundle="${storeText}" key="BCT_SHOPPING_CART"/></span>
													</a> 
													<span class="step_arrow"></span>
	
													<%--
														If validAddressId is empty, this means there are no common addresses. In B2C, users will be asked to entered addresses. 
														In B2B, since address can be set in the contracts already, we'll skip the address page and go directly to the multiple 
														shipment page if there are no common addresses. If there is a common address, the single shipment page will be displayed.
													--%>
													<c:choose>
														<c:when test="${empty validAddressId}">
															<c:if test="${(!env_contractSelection && orderItemsHaveInvalidAddressId) || (env_contractSelection && WCParam.guestChkout == '1' )}">
																<span class="step_on"><fmt:message bundle="${storeText}" key="BCT_ADDRESS"/></span>
																<span class="step_arrow"></span>
															</c:if>
															<c:set var="highlightShippingBilling" value="step_off"/>
															<c:if test="${env_contractSelection && !(WCParam.guestChkout == '1')}"><c:set var="highlightShippingBilling" value="step_on"/></c:if>
															<span class="${highlightShippingBilling}" ><fmt:message bundle="${storeText}" key="BCT_SHIPPING_AND_BILLING"/></span>
															<span class="step_arrow"></span>
														</c:when>
														<c:otherwise>
															<span class="step_on"><fmt:message bundle="${storeText}" key="BCT_SHIPPING_AND_BILLING"/></span>
															<span class="step_arrow"></span>
														</c:otherwise>					
													</c:choose>
													<span class="step_off">Order Confirmation</span>
												</c:if>
											</div>
										</div>
										<!-- Breadcrumb End -->
									</flow:ifEnabled>

									<flow:ifDisabled feature="SharedShippingBillingPage">
										<div id="checkout_crumb">
											<div class="crumb" id="WC_ShipmentDisplay_div_4">
												<c:if test = "${!empty order.orderItem}">
													<a href="<c:out value="${ShoppingCartURL}"/>" id="WC_ShipmentDisplay_links_2">
														<span class="step_off"><fmt:message bundle="${storeText}" key="BCT_SHOPPING_CART"/></span>
													</a>
													<span class="step_arrow"></span>
													<c:if test="${empty validAddressId}">
														<span class="step_on"><fmt:message bundle="${storeText}" key="BCT_ADDRESS"/></span>
														<span class="step_arrow"></span>
														<span class="step_off"><fmt:message bundle="${storeText}" key="TRA_SHIPPING"/></span>
														<span class="step_arrow"></span>
														<span class="step_off"><fmt:message bundle="${storeText}" key="TRA_BILLING"/></span>
														<span class="step_arrow"></span>
													</c:if>
													<c:if test="${!empty validAddressId}">
														<span class="step_on"><fmt:message bundle="${storeText}" key="BCT_SHIPPING"/></span></a>
														<span class="step_arrow"></span>
														<span class="step_off"><fmt:message bundle="${storeText}" key="BCT_BILLING"/></span>
														<span class="step_arrow"></span>
													</c:if> 
													<span class="step_off"><fmt:message bundle="${storeText}" key="BCT_ORDER_SUMMARY"/></span>
												</c:if>
											</div>
										</div>
									</flow:ifDisabled>
									<div id="mainContents" style="display:block">
										<div id="box" class="orderShippingBillPage">
										<br clear="all"/>
											<fmt:parseNumber var="numEntries" value="${shippingInfo.recordSetTotal}" integerOnly="true" />
											<%out.flush();%>
											<c:import url="/${sdb.jspStoreDir}/ShoppingArea/CheckoutSection/ShippingDetailsDisplay.jsp">
												<c:param value="${shipmentTypeId}" name="shipmentTypeId"/>
												<c:param value="${numEntries}" name="recordSetTotal"/>
												<c:param value="${currentOrderId}" name="orderId"/>
												<c:param value="${selectedAddressId}" name="addressId" />
											</c:import>
											<%out.flush();%>
											<br clear="all" />	                                 
					
											<flow:ifEnabled feature="SharedShippingBillingPage">
												<c:set var="scheduledOrderEnabled" value="false"/>
												<c:set var="recurringOrderEnabled" value="false"/>
												<flow:ifEnabled feature="ScheduleOrder">
													<c:set var="scheduledOrderEnabled" value="true"/>
												</flow:ifEnabled>
												<flow:ifEnabled feature="RecurringOrders">
													<c:set var="recurringOrderEnabled" value="true"/>
													<c:set var="cookieKey1" value="WC_recurringOrder_${currentOrderId}"/>
													<c:set var="currentOrderIsRecurringOrder" value="${cookie[cookieKey1].value}"/>
												</flow:ifEnabled>
												<c:choose>
													<c:when test="${scheduledOrderEnabled == 'true'}">
														<%out.flush();%>
														<c:import
																	url="/${sdb.jspStoreDir}/ShoppingArea/CheckoutSection/ScheduleOrderDisplayExt.jsp">
																	<c:param value="false" name="isShippingBillingPage" />
																	<c:param value="${WCParam.frequency}" name="frequency" />
																	<c:param value="${WCParam.startDate}" name="startDate" />
																	<c:param value="${WCParam.endDate}" name="endDate" />
																	<c:param value="${WCParam.ScheduleOrderTime}"
																		name="ScheduleOrderTime" />
																	<c:param value="${WCParam.ScheduleOrderAP}"
																		name="ScheduleOrderAP" />
																	<c:param value="${currentOrderId}" name="orderId" />
														</c:import>
														<%out.flush();%>
													</c:when>
													<c:when test="${recurringOrderEnabled == 'true' && currentOrderIsRecurringOrder == 'true'}">
														<%out.flush();%>
														<c:import url="/${sdb.jspStoreDir}/ShoppingArea/CheckoutSection/RecurringOrderCheckoutDisplay.jsp">
															<c:param value="true" name="isShippingBillingPage"/>
															<c:param value="${currentOrderId}" name="orderId"/>
														</c:import>
														<%out.flush();%>
													</c:when>
												</c:choose>
												<br clear="all" />		
			 									<!-- Start code added by ali for Purchase Order and Cost Center functionality in Order Summary page -->
			 									
												<input type="hidden" name="CostCenter" id="costCentre_id" value="${WCParam.costCentre }"/>
												<!-- End code added by ali for Purchase Order and Cost Center functionality in Order Summary page -->
												<div class="ordShipBillHeaders" id="WC_ShipmentDisplay_div_22" onclick="ShowHideItem('headPlus1','shipInfoBody');">
													<div class="ordShipHeaderSign headPlus1">-</div>
														<div class="left_corner_straight" id="WC_ShipmentDisplay_div_23"></div>
													<div class="ordShipBillHeaderTxt" id="WC_ShipmentDisplay_div_7"><span aria-level="1" class="main_header_text" role="heading">Shipping & Billing</span></div>
													<%--ali commit <div class="headingtext" id="WC_ShipmentDisplay_div_24"><span aria-level="1" class="main_header_text" role="heading"><fmt:message bundle="${storeText}" key="BILL_BILLING_INFO"/></span></div>--%>
													<div class="right_corner_straight" id="WC_ShipmentDisplay_div_25"></div>
												</div>
												<%--ali added start --%>
												<div class="col12 row shipInfoBody" > 
													<div class="col3 acol12 adjustWidth50">
													<div class="shipInfoRefreshArea" wcType="RefreshArea" id="shippingAddressSelectBoxArea" widgetId="shippingAddressSelectBoxArea" declareFunction="declareShippingAddressSelectBoxAreaController()">
														 <%out.flush();%>
															<c:import url="/${sdb.jspStoreDir}/ShoppingArea/CheckoutSection/SingleShipment/ShippingAddressSelect.jsp">
																<c:param value="${addressId}" name="addressId"/>
																 <c:param value="${order.orderId}" name="orderId"/>
															</c:import>
														<%out.flush();%>
													</div>
													</div>
													<div class="col3 acol12 adjustWidth50">
													<div class="shipInfoShipMethod">
													<%out.flush();%>
														<c:import url="/${sdb.jspStoreDir}/ShoppingArea/CheckoutSection/SingleShipment/SingleShipmentShippingMethodDetails.jsp">
															 <c:param value="${order.orderId}" name="orderId"/>
														</c:import>
													<%out.flush();%>
												</div>
												</div>
												<%--ali added end --%>
												<!-- Display drop down box to select number of payment options.. -->
												
												
												<c:set var="showPayInStore" value="false"/>
													<div class="col6 acol12 adjustWidth100">
														<div class="shipping_billing_height" id="WC_ShipmentDisplay_div_30">
															<%@ include file="CheckoutPaymentsAndBillingAddress.jspf"%>
															<%@ include file="OrderAdditionalDetailExt.jspf"%>
														</div>
													</div>
												</div>
											</flow:ifEnabled>

											<br/ clear="all">
											<div class="ordShipBillHeaders" onclick="ShowHideItem('headPlus3','shipOrderTotal');">
													<div class="ordShipHeaderSign headPlus3">-</div>
													<div class="ordShipBillHeaderTxt"><span class="main_header_text">Order Totals</span></div>
											</div>
												
											<div class="col12 row shipOrderTotal">	
												<div class="shipOrderTotalRefArea" wcType="RefreshArea" widgetId="singleShipmentOrderTotalsDetail"  declareFunction="declareCurrentOrderTotalsAreaController()" id="WC_ShipmentDisplay_div_18" ariaMessage="<fmt:message bundle="${storeText}" key="ACCE_Status_Order_Total_Updated"/>" ariaLiveId="${ariaMessageNode}" role="region" aria-labelledby="singleShipmentOrderTotalsDetail_ACCE_Label">
													<%out.flush();%>
														<c:import url="/${sdb.jspStoreDir}/ShoppingArea/CheckoutSection/SingleShipment/SingleShipmentOrderTotalsSummary.jsp">
															<%-- OrderShippingBillingView is used both in AJAX and non-AJAX checkout flow --%>
															<c:param name="returnView" value="OrderShippingBillingView"/>
															<c:param name="fromPage" value="${fromPage}"/>
														</c:import>
													<%out.flush();%>
												</div>
											</div>
											
											
											<div class="button_footer_line navBase" id="WC_ShipmentDisplay_div_32_1"> 
												<div class="nav">
												<div class="btnHolder">
													<div id="getRates" style="display:none;"><!-- <p class="currentOrder">Current Order</p> -->
														<table id="getRatesTable"><tr>
															<td class="order_total"></td>
															<td class="breadcrumb_current"></td>
															</tr>
														</table>
														</div>
												
												<div class="submitBtnAndBackBtn">
													<a role="button" class="button_primary  tlignore" id="shippingBillingPageNext" tabindex="0" href="JavaScript:setCurrentId('shippingBillingPageNext'); CheckoutPayments.processCheckout('PaymentForm','','false');">
														<div class="left_border"></div>
														<flow:ifEnabled feature="SharedShippingBillingPage">
															<div class="button_text">Complete Order<span class="spanacce"><fmt:message bundle="${storeText}" key="Checkout_ACCE_next_summary"/></span></div>
														</flow:ifEnabled>
														<flow:ifDisabled feature="SharedShippingBillingPage">
															<div class="button_text">Complete Order<fmt:message bundle="${storeText}" key="Checkout_ACCE_next_bill"/></span></div>
														</flow:ifDisabled>
														<div class="right_border"></div>
													</a>
													<%-- <a role="button" class="button_secondary button_left_padding tlignore" id="WC_ShipmentDisplay_links_5" tabindex="0" href="javascriRecurringOrderCheckoutDisplay.jsppt:setPageLocation('<c:out value='${ShoppingCartURL}'/>')">
														<div class="left_border"></div>
														<div class="button_text"><fmt:message bundle="${storeText}" key="BACK"/><span class="spanacce"><fmt:message bundle="${storeText}" key="Checkout_ACCE_back_shopping_cart"/></span></div>
														<div class="right_border"></div>
													</a> --%>
												</div>
												</div>
												</div>
												<%--
												<span class="button_right_side_message" id="WC_ShipmentDisplay_div_32_3">
													<flow:ifEnabled feature="SharedShippingBillingPage">
														<fmt:message bundle="${storeText}" key="ORD_MESSAGE"/>
													</flow:ifEnabled>
													<flow:ifDisabled feature="SharedShippingBillingPage">
														<fmt:message bundle="${storeText}" key="ORD_MESSAGE_BILLING"/>
													</flow:ifDisabled>
												</span>
												 --%>
												
												<!--For eWay Start-->
												<c:set var="enStoreId" value="${WCParam.storeId}" scope="page"/>
												<c:set var="enOrderId" value="${currentOrderId}" scope="page"/>
												<c:set var="selectedStoreIdForON" value="${WCParam.selectedStoreIdForON}" scope="page"/>
												<c:if test="${WCParam.storeId ne '98552'}">
													<c:set var="selectedStoreIdForON" value="0" scope="page"/>
												</c:if>
												
												
												<wcf:rest var="getEwayEnKey" url="store/{storeId}/ordersummary/getEwayEnKey/{orderId}/{selectedStoreIdForON}" scope="request">
													<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
													<wcf:var name="orderId" value="${order.orderId}" encode="true"/>
													<wcf:var name="selectedStoreIdForON" value="${selectedStoreIdForON}" encode="true"/>
												</wcf:rest>	
												
												<input type="hidden" name="enKey" id="enKey" value="<c:out value="${getEwayEnKey.enkey }"/>"/>
												<input type="hidden" id="piIdCustom" name="piIdCustom" value="${getEwayEnKey.piId}" />
												<!--For eWay End-->
												
												</div>
												</div>
											</div>
											<br clear="all" />
											<div class="espot_checkout_bottom" id="WC_ShipmentDisplay_div_38">
												<%@ include file="../../Snippets/ReusableObjects/CheckoutBottomESpotDisplay.jspf"%>
											</div>
										</div>
									</div>
									<!-- Edit address div -->
									<div id="editAddressContents" style="display:none">
										<!-- Start of second div in this page -->
										<span class="spanacce" id="editShippingAddressArea1_ACCE_Label"><fmt:message bundle="${storeText}" key="Checkout_ACCE_edit_create_address"/></span>
										<div wcType="RefreshArea" id="editShippingAddressArea1" aria-labelledby="editShippingAddressArea1_ACCE_Label" widgetId="editShippingAddressArea1" declareFunction="declareEditShippingAdddressAreaController()"
											refreshurl="${editAddressDisplayURL}">
										</div>
									</div>
									<!-- Main Content End -->									
								</div>
							</div>
						</div>
					</div>
					<!-- Main Content End -->                           
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<!-- Footer Start -->
	<div class="footer_wrapper_position">
		<%out.flush();%>
			<c:import url = "${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
		<%out.flush();%>
	</div>
	<!-- Footer End -->
	<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	<%@ include file="../../Common/JSPFExtToInclude.jspf"%> 
	<%@ include file="../../CustomerService/CSROrderSliderWidget.jspf" %>

<script type="text/javascript">
$(document).ready(function() { 
		CheckoutPayments.setNumberOfPaymentMethods(1,document.getElementById('numberOfPaymentMethods'),'paymentSection');
		CheckoutPayments.reinitializePaymentObjects(document.getElementById('numberOfPaymentMethods'));
		
		var minChargeApply=document.getElementById('minChargeApply').value;
		var minimumCharges=document.getElementById('minimumCharges').value;
		var minimumValue=document.getElementById('minimumValue').value;
		if(minChargeApply=='true' && minimumCharges != '0.0'){
			minimumCharges = minimumCharges/1;
			minimumValue = minimumValue/1;
			minimumCharges = minimumCharges.toFixed(2);
			minimumValue = minimumValue.toFixed(2);
			alert("Your order is below our minimum value for free delivery, and will incur a $"+minimumCharges+" freight charge.\nYou can remove this fee simply by adding additional items to your cart so the value exceeds $"+minimumValue+".\nIf your delivery is out of the Metro area a freight fee may apply, customer service will contact you on this.");
			CheckoutPayments.getTotalInJSON();
		}		
	});
</script> 
<input type="hidden" name="domainNameForON" id="domainNameForON" value="<%=request.getServerName() %>"/>	
	
	</body>
</html>
<script>
	var step = 3;
	if ('${param.gmtStep}' == '2' || '${param.guestChkout}' == '1') {
		step = 2;
	}
	dataLayer.push({
		'event': 'checkout',
		'ecommerce': {
			'checkout': {
				'actionField': {'step': step}//Number of step which should be incremented.
			 }
		 }
	});

	$(window).scroll(function(){
		var yourTop = $('.navBase').position().top;
		//console.log($('.navBase').position().top);
		if( $(this).scrollTop() > yourTop ){
			$(".nav").addClass("sticky");
			$("#getRates").show();
		}
		else if( $(this).scrollTop() > yourTop - ($( window ).height() - 75) &&  $(this).scrollTop() < yourTop ){
			$(".nav").removeClass("sticky");
			$(".nav").removeClass("stickyBottom");
			$("#getRates").hide();
		}
		else {
			$(".nav").addClass("stickyBottom");
			$("#getRates").show();
			
		}
	});
	$("#getRatesTable .order_total").append($(".orderTotalSumAmount .order_total").html());
	$("#getRatesTable .breadcrumb_current").append($(".orderTotalSumAmount .breadcrumb_current").html());
	 
</script>
<!-- END OrderShippingBillingDetails.jsp -->