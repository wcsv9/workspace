//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*

    function submitErrorHandler (errMessage)
    {
	alertDialog(errMessage);
    }

    function submitFinishHandler (finishMessage)
    {
	alertDialog(finishMessage);
	top.goBack();
    }

    function submitCancelHandler()
    {
	top.goBack();
    }

    function validateAllPanels() 
    {
  	return true;
    }
