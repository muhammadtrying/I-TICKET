package uz.muhammadtrying.iticketproject.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.OneToOne;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.UUID;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
@NoArgsConstructor
public class AttachmentContent extends BaseEntity {
    @OneToOne
    protected Attachment attachment;
    private byte[] content;

    @Builder
    public AttachmentContent(UUID id, Attachment attachment, byte[] content) {
        super(id);
        this.attachment = attachment;
        this.content = content;
    }
}
