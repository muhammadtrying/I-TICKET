package uz.muhammadtrying.iticketproject.entity;

import jakarta.persistence.CascadeType;
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
public class Movie extends BaseEntity {
    private String name;
    @OneToOne
    private Attachment attachment;

    @Builder
    public Movie(UUID id, String name, Attachment attachment) {
        super(id);
        this.name = name;
        this.attachment = attachment;
    }
}
