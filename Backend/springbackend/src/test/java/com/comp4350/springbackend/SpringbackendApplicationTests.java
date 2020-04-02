package com.comp4350.springbackend;

import com.comp4350.springbackend.model.Customer;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * run in terminal with commend 'mvn -Dtest=com.comp4350.springbackend.SpringbackendApplicationTests test'
 */
@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
public class SpringbackendApplicationTests {


    @Autowired
    private MockMvc mockMvc;

    @Test
    public void testOrderWithOutToken() throws Exception {
        String content = mockMvc.perform(MockMvcRequestBuilders.get("/order/a"))
                .andDo(print())
                .andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();

        final String UNAUTHORIZED = "{\"headers\":{},\"body\":\"Login Please\",\"statusCode\":\"UNAUTHORIZED\",\"statusCodeValue\":401}";

        Assert.assertEquals(content, UNAUTHORIZED);
    }

    @Test
    public void testOrderWithToken() throws Exception {
        Customer customer = new Customer("c", "1");

        //convert to json string
        ObjectMapper mapper = new ObjectMapper();
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(customer);
        //get token
        String token = mockMvc.perform(post("/register").contentType(MediaType.APPLICATION_JSON)
                .content(requestJson)).andDo(print())
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();

        LoggerFactory.getLogger(SpringbackendApplicationTests.class).debug(token);

        String content = mockMvc.perform(MockMvcRequestBuilders.get("/order/a").header("token", token))
                .andDo(print())
                .andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();

        final String success = "[]"; // no order

        Assert.assertEquals(content, success);
    }

}
