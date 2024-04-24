package uz.muhammadtrying.iticketproject.entity;

import jakarta.persistence.Entity;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.UUID;

@EqualsAndHashCode(callSuper = true)
@Entity
@NoArgsConstructor
@Data
public class Hall extends BaseEntity {
    private String name;
    @Builder
    public Hall(UUID id, String name) {
        super(id);
        this.name = name;
    }
}
