package com.ibm.commerce.order.ue.entities;

import com.ibm.commerce.copyright.IBMCopyright;
import com.ibm.commerce.foundation.entities.ReplaceUERequest;
import com.ibm.commerce.order.entities.Order;

public class OrderReplaceUERequest extends ReplaceUERequest implements
		OrderUERequest {

	/**
	 * IBM copyright notice field.
	 */
	@SuppressWarnings("unused")
	private static final String COPYRIGHT = IBMCopyright.SHORT_COPYRIGHT;

	private Order order;

	@Override
	public Order getOrder() {
		return this.order;
	}

	@Override
	public void setOrder(Order order) {
		this.order = order;
	}

}
