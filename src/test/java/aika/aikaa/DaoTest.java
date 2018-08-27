package aika.aikaa;

import aika.aikaa.daos.EventDao;
import aika.aikaa.daos.RoleDao;
import aika.aikaa.daos.UserDao;
import aika.aikaa.objects.Event;
import aika.aikaa.objects.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.*;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class DaoTest {
    @Autowired
    private EventDao ed;
    @Autowired
    private UserDao ud;
    @Autowired
    private RoleDao rd;
    @Autowired
    private TestRestTemplate tr;

    @Test
    public void listaRoolissaToimivista() {
        List<User> roleUserList = ud.listOfAllUsersWithRoleId(1);
        assertEquals(roleUserList.size(), 2);
        assertEquals(roleUserList.get(0).getName(), "Muusikko1");
        assertEquals(roleUserList.get(0).getId(), (Integer) 1);
    }

    @Test
    public void yhdenToimijanRoolit() {
        User userWithRoles = ud.oneUserWithRoles(4);
        assertEquals(userWithRoles.getRoles().size(), 2);
        assertEquals(userWithRoles.getRoles().get(0).getName(), "Sellisti");
        assertEquals(userWithRoles.getUserLevel(), (Integer) 3);
        assertEquals(userWithRoles.getName(), "Muusikko4");
    }

    @Test
    public void yhdenEventinBiisit() {
        Event eventWithWorks = ed.oneEventWithWorks(1);
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
        assertThat(response.getStatusCode(), is(HttpStatus.OK));
        Event created = response.getBody();
        assertThat(created.getId(), is(notNullValue()));
    }

// TODO: korjaa allaoleva testi. Delete-toiminto on kunnossa.
//    @Test
//    public void muuttaaEventin() {
//        Event e = new Event("Testikonsertti3");
//        HttpEntity<Event> request = new HttpEntity<>(e);
//        ResponseEntity<Event> response = tr
//                .exchange("/api/events/7", HttpMethod.PUT, request, Event.class);
//
//        assertThat(response.getStatusCode(), is(HttpStatus.OK));
//    }

    @Test
    public void poistaaEventin() {
        tr.delete("/events/8");
        ResponseEntity<Event> response = tr.getForEntity("/events/8",
                Event.class);
        assertEquals(404, response.getStatusCodeValue());
        Event a = response.getBody();
        assertThat(a.getId(), is(nullValue()));
    }
}
