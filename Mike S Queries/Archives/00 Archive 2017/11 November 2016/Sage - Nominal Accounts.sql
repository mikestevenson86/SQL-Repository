SELECT nt.NLPostedNominalTranID, nt.DateTimeCreated, nt.Narrative, nt.PostedDate, nt.TransactionAnalysisCode, nt.UserName, nt.DocumentCurrencyID,
nt.ExchangeRate, nt.GoodsValueInBaseCurrency, nt.GoodsValueInDocumentCurrency, nt.NLNominalTranTypeID, NLPostedNominalTranID,
nt.OpLock, nt.Source, nt.UniqueReferenceNumber, nt.UserNumber, na.AccountName, na.AccountNumber
FROM CitationPLCLive..NLPostedNominalTran nt
inner join CitationPLCLive..NLNominalAccount na ON nt.NLNominalAccountID = na.NLNominalAccountID
WHERE na.AccountNumber = 10104