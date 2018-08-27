package kurssi.kokeiluprojekti;

import kurssi.kokeiluprojekti.daos.KokeiluDao;
import kurssi.kokeiluprojekti.objects.Event;
import kurssi.kokeiluprojekti.objects.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.*;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class DaoTest {
    @Autowired
    private KokeiluDao kd;
    @Autowired
    private TestRestTemplate tr;

    @Test
    public void listaRoolissaToimivista() {
        List<User> roleUserList = kd.listOfAllUsersWithRole(1);
        assertEquals(roleUserList.size(), 2);
        assertEquals(roleUserList.get(0).getName(), "Muusikko1");
        assertEquals(roleUserList.get(0).getId(), (Integer) 1);
    }

    @Test
    public void yhdenToimijanRoolit() {
        User userWithRoles = kd.oneUserWithRoles(4);
        assertEquals(userWithRoles.getRoles().size(), 2);
        assertEquals(userWithRoles.getRoles().get(0).getName(), "Sellisti");
        assertEquals(userWithRoles.getUserLevel(), (Integer) 3);
        assertEquals(userWithRoles.getName(), "Muusikko4");
    }

    @Test
    public void yhdenEventinBiisit() {
        Event eventWithWorks = kd.oneEventWithWorks(1);
        assertEquals(eventWithWorks.getWorks().size(), 3);
        assertEquals(eventWithWorks.getWorks().get(0).getWork(), "Jousikvartetto");
        assertEquals(eventWithWorks.getWorks().get(0).getMusicians(), (Integer) 4);
        assertEquals(eventWithWorks.getName(), "Konsertti1");
    }

    @Test
    public void rolesPalauttaaJsonia() {
        HttpHeaders hh = tr.headForHeaders("/api/roles");
        assertTrue(hh.getContentType().includes(MediaType.APPLICATION_JSON));
    }

//    @Test
//    public void listaEventeistä() {
//
//    }

    @Test
    public void luoEventin() {
        HttpEntity<Event> request = new HttpEntity<>(new Event("Testikonsertti"));
        ResponseEntity<Event> response = tr
                .exchange("/api/events", HttpMethod.POST, request, Event.class);
        assertThat(response.getStatusCode(), is(HttpStatus.CREATED));
        Event created = response.getBody();
        assertThat(created.getId(), is(notNullValue()));
    }

    @Test
    public void muuttaaEventin() {
        Event e = new Event("Testikonsertti2");
        e.setId(500);
        HttpEntity<Event> request = new HttpEntity<>(e);
        ResponseEntity<Event> response = tr
                .exchange("/events/5", HttpMethod.PUT, request, Event.class);

        assertThat(response.getStatusCode(), is(HttpStatus.CREATED));
    }

    @Test
    public void poistaaEventin() {
        tr.delete("/events/500");
        ResponseEntity<Event> response = tr.getForEntity("/events/500",
                Event.class);
        assertEquals(200, response.getStatusCodeValue());
        Event a = response.getBody();
        assertThat(a, is(nullValue()));
    }
}
