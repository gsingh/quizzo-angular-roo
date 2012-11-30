// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.chariot.quizzo.web;

import com.chariot.quizzo.model.Player;
import com.chariot.quizzo.model.Quiz;
import com.chariot.quizzo.web.QuizController;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect QuizController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String QuizController.create(@Valid Quiz quiz, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, quiz);
            return "quizzes/create";
        }
        uiModel.asMap().clear();
        quiz.persist();
        return "redirect:/quizzes/" + encodeUrlPathSegment(quiz.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String QuizController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Quiz());
        return "quizzes/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String QuizController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("quiz", Quiz.findQuiz(id));
        uiModel.addAttribute("itemId", id);
        return "quizzes/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String QuizController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("quizzes", Quiz.findQuizEntries(firstResult, sizeNo));
            float nrOfPages = (float) Quiz.countQuizzes() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("quizzes", Quiz.findAllQuizzes());
        }
        return "quizzes/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String QuizController.update(@Valid Quiz quiz, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, quiz);
            return "quizzes/update";
        }
        uiModel.asMap().clear();
        quiz.merge();
        return "redirect:/quizzes/" + encodeUrlPathSegment(quiz.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String QuizController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Quiz.findQuiz(id));
        return "quizzes/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String QuizController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Quiz quiz = Quiz.findQuiz(id);
        quiz.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/quizzes";
    }
    
    void QuizController.populateEditForm(Model uiModel, Quiz quiz) {
        uiModel.addAttribute("quiz", quiz);
        uiModel.addAttribute("players", Player.findAllPlayers());
    }
    
    String QuizController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
