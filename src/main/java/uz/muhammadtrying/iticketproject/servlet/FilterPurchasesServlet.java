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
        switch (filter) {
            case "hall" -> all.sort(Comparator.comparing(Purchase::getHall));
            case "movie" -> all.sort(Comparator.comparing(Purchase::getMovie));
            case "sessionTime" -> all.sort(Comparator.comparing(Purchase::getSessionTime));
            case "price" -> all.sort(Comparator.comparing(Purchase::getPrice));
            case "purchasedAt" -> all.sort(Comparator.comparing(Purchase::getPurchaseDate));
            case "user" -> all.sort(Comparator.comparing(u -> u.getUser().getUsername()));
        }
        req.setAttribute("filteredPurchases", all);
        req.getRequestDispatcher("/report.jsp").forward(req, resp);
    }
}
