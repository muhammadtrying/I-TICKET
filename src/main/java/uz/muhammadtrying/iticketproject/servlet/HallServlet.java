package uz.muhammadtrying.iticketproject.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.muhammadtrying.iticketproject.entity.Hall;
import uz.muhammadtrying.iticketproject.repo.HallRepo;

import java.io.IOException;
import java.util.UUID;

@WebServlet(value = "/hallServlet")
public class HallServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HallRepo hallRepo = new HallRepo();
        if (req.getParameter("function") != null && req.getParameter("function").equals("update")) {
            Hall hall = hallRepo.findById(UUID.fromString(req.getParameter("id")));
            hallRepo.begin();
            hall.setName(req.getParameter("name"));
            hallRepo.commit();
        } else {
            String name = req.getParameter("name");
            Hall hall = Hall.builder()
                    .name(name)
                    .build();
            hallRepo.save(hall);
        }
        resp.sendRedirect("/hallCrud.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HallRepo hallRepo = new HallRepo();
        Hall hall = hallRepo.findById(UUID.fromString(req.getParameter("id")));
        hallRepo.delete(hall.getId());
        resp.sendRedirect("/hallDelete.jsp");
    }
}
