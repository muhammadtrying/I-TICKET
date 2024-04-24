package uz.muhammadtrying.iticketproject.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.muhammadtrying.iticketproject.entity.Purchase;
import uz.muhammadtrying.iticketproject.repo.PurchaseRepo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@WebServlet(value = "/filter-purchases")
public class FilterPurchasesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        PurchaseRepo purchaseRepo = new PurchaseRepo();
        List<Purchase> all = new ArrayList<>(purchaseRepo.findAll());
        String filter = req.getParameter("filter");
        all.sort(Comparator.comparing());
        req.getRequestDispatcher("/report.jsp").forward(req, resp);
    }
}
