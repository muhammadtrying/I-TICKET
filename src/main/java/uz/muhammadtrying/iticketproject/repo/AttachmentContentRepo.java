package uz.muhammadtrying.iticketproject.repo;

import uz.muhammadtrying.iticketproject.entity.AttachmentContent;

import java.util.List;
import java.util.UUID;

public class AttachmentContentRepo extends BaseRepo<AttachmentContent, UUID> {
    public AttachmentContent findByAttachmentId(UUID id) {
        List<AttachmentContent> all = findAll();
        List<AttachmentContent> list = all.stream().filter(a -> a.getAttachment().getId().equals(id)).toList();
        return list.get(0);
    }
}
