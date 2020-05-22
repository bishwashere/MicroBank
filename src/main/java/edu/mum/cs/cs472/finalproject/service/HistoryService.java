package edu.mum.cs.cs472.finalproject.service;

import edu.mum.cs.cs472.finalproject.model.History;
import edu.mum.cs.cs472.finalproject.model.TransactionSummary;
import edu.mum.cs.cs472.finalproject.repository.TransactionSummaryDao;

import java.util.Arrays;
import java.util.List;

public class HistoryService {
    private TransactionSummaryDao transactionSummaryDao;
    private HistoryService() {
        transactionSummaryDao = new TransactionSummaryDao();
    }
    private static HistoryService historyService;
    public static HistoryService getInstance() {
        if(historyService == null)
            historyService = new HistoryService();
        return historyService;
    }

    public List<TransactionSummary> getTransactions(int userId, long accountNumber, int pageIndex, int countPerPage) {
        return transactionSummaryDao.getTransactions(userId, accountNumber, pageIndex, countPerPage);
    }

    public long getTransactionsCount(int userId, long accountNumber) {
        return transactionSummaryDao.getTransactionsCount(userId, accountNumber);
    }
}
