package uz.muhammadtrying.iticketproject.servlet;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.muhammadtrying.iticketproject.entity.Attachment;
import uz.muhammadtrying.iticketproject.entity.AttachmentContent;
import uz.muhammadtrying.iticketproject.repo.AttachmentContentRepo;
import uz.muhammadtrying.iticketproject.repo.AttachmentRepo;

import java.io.IOException;
import java.util.UUID;

@WebServlet(value = "/file")
@MultipartConfig
public class FileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        AttachmentContentRepo attachmentContentRepo = new AttachmentContentRepo();
        AttachmentRepo attachmentRepo = new AttachmentRepo();
        UUID attachmentId = UUID.fromString(req.getParameter("id"));
        Attachment attachment = attachmentRepo.findById(attachmentId);
        AttachmentContent attachmentContent = attachmentContentRepo.findByAttachmentId(attachment.getId());
        resp.getOutputStream().write(attachmentContent.getContent());
    }
}
