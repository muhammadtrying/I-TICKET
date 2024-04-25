package uz.muhammadtrying.iticketproject.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import uz.muhammadtrying.iticketproject.entity.Attachment;
import uz.muhammadtrying.iticketproject.entity.AttachmentContent;
import uz.muhammadtrying.iticketproject.entity.Movie;
import uz.muhammadtrying.iticketproject.repo.AttachmentContentRepo;
import uz.muhammadtrying.iticketproject.repo.AttachmentRepo;
import uz.muhammadtrying.iticketproject.repo.MovieRepo;

import java.io.IOException;
import java.util.UUID;

@WebServlet(value = "/movieServlet")
@MultipartConfig
public class MovieServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        MovieRepo movieRepo = new MovieRepo();
        AttachmentContentRepo attachmentContentRepo = new AttachmentContentRepo();
        AttachmentRepo attachmentRepo = new AttachmentRepo();
        if (req.getParameter("name").isBlank()) {
            resp.sendRedirect("/movieCreate.jsp");
            return;
        }
        if (req.getParameter("function") != null) {
            UUID movieId = UUID.fromString(req.getParameter("id"));
            String name = req.getParameter("name");
            Part part = req.getPart("photo");
            Movie movie = movieRepo.findById(movieId);
            Attachment attachment = Attachment.builder()
                    .build();
            attachmentRepo.save(attachment);
            AttachmentContent attachmentContent = AttachmentContent.builder()
                    .attachment(attachment)
                    .content(part.getInputStream().readAllBytes())
                    .build();
            attachmentContentRepo.save(attachmentContent);
            movieRepo.begin();
            movie.setName(name);
            movie.setAttachment(attachment == null ? movie.getAttachment() : attachment);
            movieRepo.commit();
        } else {
            String name = req.getParameter("name");
            Part part = req.getPart("photo");
            if (part == null) {
                resp.sendRedirect("/movieCreate.jsp");
                return;
            }
            Attachment attachment = Attachment.builder()
                    .build();
            attachmentRepo.save(attachment);
            AttachmentContent attachmentContent = AttachmentContent.builder()
                    .attachment(attachment)
                    .content(part.getInputStream().readAllBytes())
                    .build();
            attachmentContentRepo.save(attachmentContent);
            Movie movie = Movie.builder()
                    .name(name)
                    .attachment(attachment)
                    .build();
            movieRepo.save(movie);
        }
        resp.sendRedirect("/movieCrud.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UUID movieId = UUID.fromString(req.getParameter("id"));
        MovieRepo movieRepo = new MovieRepo();
        Movie movie = movieRepo.findById(movieId);
        movieRepo.delete(movie.getId());
        resp.sendRedirect("/movieDelete.jsp");
    }
}
