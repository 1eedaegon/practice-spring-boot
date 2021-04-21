package com.lee.example.springboot.web;


import org.junit.Test;
import org.springframework.mock.env.MockEnvironment;

import static org.assertj.core.api.Assertions.assertThat;

public class ProfileControllerUnitTest {

    @Test
    public void real_profile을_조회해야_한다(){

        // Given
        String expectedProfile = "real";
        MockEnvironment env = new MockEnvironment();
        env.addActiveProfile(expectedProfile);
        env.addActiveProfile("oauth");
        env.addActiveProfile("real-db");
        ProfileController controller = new ProfileController(env);
        // When
        String profile = controller.profile();
        // Then
        assertThat(profile).isEqualTo(expectedProfile);
    }

    @Test
    public void real_profile이_없으면_첫번째_profile이_된다(){

        // Given
        String expectedProfile = "oauth";
        MockEnvironment env = new MockEnvironment();
        env.addActiveProfile(expectedProfile);
        env.addActiveProfile("real-db");
        ProfileController controller = new ProfileController(env);
        // When
        String profile = controller.profile();
        // Then
        assertThat(profile).isEqualTo(expectedProfile);
    }

    @Test
    public void active_profile이_없으면_default가_된다(){

        // Given
        String expectedProfile = "default";
        MockEnvironment env = new MockEnvironment();
        ProfileController controller = new ProfileController(env);
        // When
        String profile = controller.profile();
        assertThat(profile).isEqualTo(expectedProfile);
    }
}
