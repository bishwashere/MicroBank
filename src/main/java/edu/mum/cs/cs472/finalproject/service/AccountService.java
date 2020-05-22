package edu.mum.cs.cs472.finalproject.service;

import edu.mum.cs.cs472.finalproject.model.Account;
import edu.mum.cs.cs472.finalproject.repository.AccountDao;

import java.util.List;

public class AccountService {
    private static AccountService accountService;
    private AccountDao accountDao;
    private AccountService() {
        accountDao = new AccountDao();
    }

    static public AccountService getInstance() {
        if(accountService == null) {
            accountService = new AccountService();
        }
        return  accountService;
    }

    public List<Account> getAccounts(int userId) {
        return accountDao.getAccounts(userId);
    }
}