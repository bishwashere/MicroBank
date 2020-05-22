package edu.mum.cs.cs472.finalproject.controller.protocol;


import edu.mum.cs.cs472.finalproject.controller.protocol.Result;
import edu.mum.cs.cs472.finalproject.model.Account;

import java.util.List;

public class AccountsResult extends Result {
    private List<Account> accounts;

    public AccountsResult(int code, String msg, List<Account> accounts) {
        super(code, msg);
        this.accounts = accounts;
    }
}