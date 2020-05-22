package edu.mum.cs.cs472.finalproject.controller;

import edu.mum.cs.cs472.finalproject.model.Account;
import edu.mum.cs.cs472.finalproject.model.TransactionSummary;
import edu.mum.cs.cs472.finalproject.service.AccountService;
import edu.mum.cs.cs472.finalproject.service.HistoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Console;
import java.io.IOException;
import java.util.List;

@WebServlet(description = "HistoryController", urlPatterns = {"/history"})
public class HistoryController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int countPerPage = 10;
        int pageIndex = 1;
        try {
            pageIndex = Integer.parseInt(req.getParameter("page"));
        } catch (Exception e) {

        }


        long accountNumber = 0;
        try {
            accountNumber = Long.parseLong(req.getParameter("account"));
        } catch (Exception e) {
        }

        int userId = (int)req.getAttribute("userId");

        List<TransactionSummary> transactionSummaries = HistoryService.getInstance().getTransactions(userId, accountNumber, pageIndex, countPerPage);
        long totalCount = HistoryService.getInstance().getTransactionsCount(userId, accountNumber);

        List<Account> myAccounts = AccountService.getInstance().getAccounts(userId);

        long totalPages = (totalCount + countPerPage - 1) / countPerPage;

        req.setAttribute("totalPages", totalPages);
        req.setAttribute("pageIndex", pageIndex);
        req.setAttribute("countPerPage", countPerPage);
        req.setAttribute("transactionSummaries", transactionSummaries);
        req.setAttribute("myAccounts", myAccounts);
        req.setAttribute("account", accountNumber);

        req.getRequestDispatcher("WEB-INF/views/history.jsp").forward(req, resp);
    }
}
