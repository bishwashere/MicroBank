package edu.mum.cs.cs472.finalproject.service;

import edu.mum.cs.cs472.finalproject.model.Account;
import edu.mum.cs.cs472.finalproject.model.FundTransfer;
import edu.mum.cs.cs472.finalproject.model.TransactionSummary;
import edu.mum.cs.cs472.finalproject.model.User;
import edu.mum.cs.cs472.finalproject.repository.AccountDao;
import edu.mum.cs.cs472.finalproject.repository.FundTransferDao;
import edu.mum.cs.cs472.finalproject.repository.TransactionSummaryDao;
import edu.mum.cs.cs472.finalproject.repository.UserDao;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Date;

public class TransferService {
    private static TransferService transferService;
    private FundTransferDao fundTransferDao;
    private AccountDao accountDao;
    private UserDao userDao;
    private TransactionSummaryDao transactionSummaryDao;

    private TransferService() {
        fundTransferDao = new FundTransferDao();
        userDao = new UserDao();
        accountDao = new AccountDao();
        transactionSummaryDao = new TransactionSummaryDao();
    }

    public static TransferService getInstance() {
        if(transferService == null) {
            transferService = new TransferService();
        }
        return transferService;
    }

    public boolean transfer(long from, long to, double amount, int userId) {
        User user = userDao.getUserById(userId);
        if(user == null)
            return false;

        FundTransfer fundTransfer = new FundTransfer();
        fundTransfer.setAmount(amount);
        fundTransfer.setFromAccount(from);
        fundTransfer.setToAccount(to);
        fundTransfer.setUser(user);

        boolean ret = fundTransferDao.saveFundTransfer(fundTransfer);
        if(!ret)
            return false;

        Account accountFrom = accountDao.getAccount(from);
        Account accountTo = accountDao.getAccount(to);

        ZoneId zoneId = ZoneId.systemDefault();
        ZonedDateTime zdt = LocalDateTime.now().atZone(zoneId);
        Date date = Date.from(zdt.toInstant());

        TransactionSummary transactionSummary = new TransactionSummary();
        transactionSummary.setAmount(amount);
        transactionSummary.setFromAccount(from);
        transactionSummary.setToAccount(to);
        transactionSummary.setTransactionDate(date);
        transactionSummary.setTransactionType("transfer");


        transactionSummary.setTransactionDesc("Credit");
        transactionSummary.setUser(accountFrom.getUser());
        transactionSummaryDao.saveTransaction(transactionSummary);


        transactionSummary.setTransactionDesc("Debit");
        transactionSummary.setUser(accountTo.getUser());
        transactionSummaryDao.saveTransaction(transactionSummary);

        return true;
    }
}
