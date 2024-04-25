package uz.muhammadtrying.iticketproject.entity;

import jakarta.persistence.Entity;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.UUID;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
@NoArgsConstructor
public class Attachment extends BaseEntity {
    @Builder
    public Attachment(UUID id) {
        super(id);
    }
}
