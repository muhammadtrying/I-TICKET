package uz.muhammadtrying.iticketproject.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.muhammadtrying.iticketproject.entity.Movie;
import uz.muhammadtrying.iticketproject.repo.MovieRepo;

import java.io.IOException;
import java.util.UUID;

@WebServlet(value = "/movieServlet")
public class MovieServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        MovieRepo movieRepo = new MovieRepo();
        if (req.getParameter("function") != null) {
            UUID movieId = UUID.fromString(req.getParameter("id"));
            String name = req.getParameter("name");
            Movie movie = movieRepo.findById(movieId);
            movieRepo.begin();
            movie.setName(name);
            movieRepo.commit();
        } else {
            String name = req.getParameter("name");
            Movie movie = Movie.builder()
                    .name(name)
                    .build();
            movieRepo.save(movie);
        }
        resp.sendRedirect("/movieCrud.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws  IOException {
        UUID movieId = UUID.fromString(req.getParameter("id"));
        MovieRepo movieRepo = new MovieRepo();
        Movie movie = movieRepo.findById(movieId);
        movieRepo.delete(movie.getId());
        resp.sendRedirect("/movieDelete.jsp");
    }
}
