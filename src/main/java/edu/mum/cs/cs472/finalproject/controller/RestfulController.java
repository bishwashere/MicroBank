package edu.mum.cs.cs472.finalproject.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import edu.mum.cs.cs472.finalproject.controller.protocol.AccountsResult;
import edu.mum.cs.cs472.finalproject.controller.protocol.Result;
import edu.mum.cs.cs472.finalproject.model.Account;
import edu.mum.cs.cs472.finalproject.model.FundTransfer;
import edu.mum.cs.cs472.finalproject.model.User;
import edu.mum.cs.cs472.finalproject.repository.AccountDao;
import edu.mum.cs.cs472.finalproject.repository.FundTransferDao;
import edu.mum.cs.cs472.finalproject.repository.UserDao;
import edu.mum.cs.cs472.finalproject.service.TransferService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import static java.lang.Integer.parseInt;



@WebServlet(description = "Restful service controller", urlPatterns = {"/api/accounts", "/api/transfer", "/api/deposit",
        "/api/withdraw", "/api/histories"})
public class RestfulController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/api/accounts":
                getAccounts(req, resp);
                break;
            case "/api/histories":
                getHistories(req, resp);
                break;
            default:
                resp.sendError(404);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/api/transfer":
                transfer(req, resp);
                break;
            default:
                resp.sendError(404);
                break;
        }
    }

    private void getAccounts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int userId = parseInt(req.getParameter("userid") == null? "0" : req.getParameter("userid"));
        AccountDao accountDao = new AccountDao();
        List<Account> accounts;
        if(userId == 0) {
            accounts = accountDao.getAllAccount();
        } else {
            accounts = accountDao.getAccounts(userId);
        }

        AccountsResult result = new AccountsResult(0, "", accounts);
        Gson gson = new GsonBuilder().create();
        String json = gson.toJson(result);

        resp.setContentType("application/json; charset=utf-8");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().append(json);
    }

    private void transfer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long from = Long.parseLong(req.getParameter("from"));
        long to = Long.parseLong(req.getParameter("to"));
        Double amount = Double.parseDouble(req.getParameter("amount"));
        int userId = (int)req.getAttribute("userId");

        boolean success =TransferService.getInstance().transfer(from, to, amount, userId);
        Result result;

        if(success)
            result = new Result(0, "");
        else
            result = new Result(1, "");


        Gson gson = new GsonBuilder().create();
        String json = gson.toJson(result);

        resp.setContentType("application/json; charset=utf-8");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().append(json);
    }

    private void getHistories(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

}
