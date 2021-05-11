package com.corp.portal.service;

import com.corp.portal.domain.*;
import com.corp.portal.repos.AgreementRepo;
import com.corp.portal.repos.ConfigRepo;
import com.corp.portal.repos.RouteRepo;
import com.corp.portal.repos.SequenceRepo;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.borders.Border;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.layout.property.VerticalAlignment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class AgreementService {
    @Autowired
    private AgreementRepo agreementRepo;
    @Autowired
    private UserService userService;
    @Autowired
    private SequenceRepo sequenceRepo;
    @Autowired
    private RouteRepo routeRepo;
    @Autowired
    private FileService fileService;
    @Autowired
    private AgFileService agFileService;
    @Autowired
    private TaskService taskService;
    @Autowired
    private UtilService utilService;
    @Autowired
    private MailService mailService;
    @Autowired
    private ConfigRepo configRepo;

    public void addRoute(Route route, Map<String, String> form){
        Route routeDb = routeRepo.findByName(route.getName());
        Sequence sequence = createSequence(form);
    if (routeDb == null){
        routeRepo.save(route);
        sequence.setRoute(route);
    }else{
        sequence.setRoute(routeDb);
    }
    sequenceRepo.save(sequence);
    }

    public void createAgreement(User user, Map<String, String> form, MultipartFile[] file) {
        Route route = routeRepo.findById(Long.valueOf(form.get("route"))).get();
        List<Sequence> sequenceList = sequenceRepo.findByRoute(route);
        Integer deadline = 0;
        for (Sequence sequence : sequenceList){
            deadline = deadline + sequence.getDeadline();
        }
        route.setSequence(sequenceList);
        Agreement agreement = new Agreement();
        agreement.setName(form.get("name"));
        agreement.setDeadline(new SimpleDateFormat("dd MMM yyyy", new Locale("ru")).format(generateDeadline(deadline)));
        agreement.setDatecreate(utilService.dateOfStr());
        agreement.setLastActive(utilService.dateOfStr());
        agreement.setAuthor(user);
        agreement.setStatus("Активный");
        agreement.setPath(fileService.createAgPath(agreement));
        agreement.setRoute(route);
        agreement.setParentT(Long.valueOf(form.get("parentT")));
        agreement.setDescription(form.get("description"));
        agreement.setResponsible(userService.findById(Long.valueOf(form.get("responsible"))));
        agreementRepo.save(agreement);
        if (!file[0].getOriginalFilename().isEmpty()){
            agFileService.addFile(agreement.getPath(),file,user,agreement);
        }
        taskService.createAgTask(agreement,route,route.getSequence());
    }

    public Sequence createSequence(Map<String, String> form){
        Sequence sequence = new Sequence();
        sequence.setNumber(Long.valueOf(form.get("number")));
        sequence.setUser(userService.findById(Long.valueOf(form.get("stage"))));
        sequence.setDeadline(Integer.valueOf(form.get("deadline")));
        return sequence;
    }

    public List getRouteList(){
        return (List) routeRepo.findAll();
    }

    public List<AgFile> getFileList(Task agTask) {
        return findById(agTask.getParentA()).getFile();
    }

    public AgFile getFile(Long id) {
        return agFileService.findById(id);
    }

    public Task getParentTask(Agreement agreement){
        return taskService.findById(agreement.getParentT());
    }

    public Agreement findById(Long id){
        Agreement agreement = agreementRepo.findById(id).get();
        agreement.getRoute().setSequence(sequenceRepo.findByRoute(agreement.getRoute()));
        return agreement;
    }

    public List findByAuthor(User author){
        List<Agreement> agList = agreementRepo.findByAuthor(author);
        return agList;
    }

    public List<Task> findByAgreement(Agreement agreement){
        return taskService.getByAgreement(agreement);
    }

    public List<Task> findByResponsible(User responsible){
        return taskService.findByResponsible(responsible);
    }

    public List findAgreement(Task task, User user) {
        return agreementRepo.findByParentTAndAuthorOrResponsible(task.getId(), user, user);
    }

    public Task findTaskById(Long id){
        return taskService.findById(id);
    }

    public List findTask(User user){
        return taskService.findByAuthorOrTeamOrResponsible(user);
    }

    public List findAllUser() {
        return userService.findAll();
    }

    public void setLastActive(Long agreement){
        Agreement agreementDb = agreementRepo.findById(agreement).get();
        agreementDb.setLastActive(utilService.dateOfStr());
        agreementRepo.save(agreementDb);
    }

    public void setStatus(Long agreement){
        Agreement agFromDb = agreementRepo.findById(agreement).get();
        agFromDb.setStatus("Согласовано");
        agreementRepo.save(agFromDb);
        mailService.sendAgAuthorApprove(agFromDb);
    }

    public Date generateDeadline(Integer i){
        Calendar calendar = GregorianCalendar.getInstance();
        calendar.add(Calendar.DAY_OF_YEAR,i);
        return calendar.getTime();
    }

    public String createPdfFile(Long id){
        Config f = configRepo.findByParamname("font");
        //InputStream f = Class.class.getResourceAsStream("font/HelveticaRegular/+");
        //String f = "src/main/resources/font/HelveticaRegular/HelveticaRegular.ttf";
        Agreement agreement = agreementRepo.findById(id).get();
        String dest = agreement.getPath() + "/" + agreement.getName() + ".pdf";
        List<Task> taskList = taskService.getByAgreement(agreement);

           try{
               PdfFont font = PdfFontFactory.createFont(f.getParam(), "Cp1251");
               PdfDocument pdf = new PdfDocument(new PdfWriter(dest));
               Document document = new Document(pdf);

               Table headTable = new Table(2,false);
               Cell head1 = new Cell().setBorder(Border.NO_BORDER).add(new Paragraph("название").setFont(font).setFontSize(8).setTextAlignment(TextAlignment.LEFT));
               Cell head2 = new Cell().setBorder(Border.NO_BORDER).add(new Paragraph(agreement.getName()).setFont(font).setFontSize(8).setTextAlignment(TextAlignment.LEFT));
               Cell head3 = new Cell().setBorder(Border.NO_BORDER).add(new Paragraph("ответственный").setFont(font).setFontSize(8).setTextAlignment(TextAlignment.LEFT));
               Cell head4 = new Cell().setBorder(Border.NO_BORDER).add(new Paragraph(agreement.getAuthor().getSurname()).setFont(font).setFontSize(8).setTextAlignment(TextAlignment.LEFT));
               Cell head5 = new Cell().setBorder(Border.NO_BORDER).add(new Paragraph("дата создания").setFont(font).setFontSize(8).setTextAlignment(TextAlignment.LEFT));
               Cell head6 = new Cell().setBorder(Border.NO_BORDER).add(new Paragraph(agreement.getDatecreate()).setFont(font).setFontSize(8).setTextAlignment(TextAlignment.LEFT));

               headTable.addCell(head1);
               headTable.addCell(head2);
               headTable.addCell(head3);
               headTable.addCell(head4);
               headTable.addCell(head5);
               headTable.addCell(head6);
               document.add(headTable);

               document.add(new Paragraph(""));
               float[] pointColumnWidths = {20F, 100F, 150F, 200F, 80F, 150F};
               Table table = new Table(pointColumnWidths);
               int i = 1;

               for (Task agTask : taskList) {
                   String agComment = agTask.getAgComment();
                    if(agComment == null){
                        agComment = "-";
                    }
                   Cell cell1 = new Cell().setVerticalAlignment(VerticalAlignment.MIDDLE).add(new Paragraph(String.valueOf(i)).setFontSize(10).setTextAlignment(TextAlignment.CENTER));
                   Cell cell2 = new Cell().setVerticalAlignment(VerticalAlignment.MIDDLE).add(new Paragraph(agTask.getResponsible().getSurname()).setFont(font).setFontSize(10).setTextAlignment(TextAlignment.CENTER));
                   Cell cell3 = new Cell().setVerticalAlignment(VerticalAlignment.MIDDLE).add(new Paragraph(String.valueOf(agTask.getResponsible().getPosition())).setTextAlignment(TextAlignment.CENTER).setFont(font).setFontSize(10));
                   Cell cell4 = new Cell().setVerticalAlignment(VerticalAlignment.MIDDLE).add(new Paragraph(agComment).setFont(font).setFontSize(10));
                   Cell cell5 = new Cell().setVerticalAlignment(VerticalAlignment.MIDDLE).add(new Paragraph(agTask.getStatus()).setTextAlignment(TextAlignment.CENTER).setFont(font).setFontSize(10));
                   Cell cell6 = new Cell().setVerticalAlignment(VerticalAlignment.MIDDLE).add(new Paragraph(String.valueOf(agTask.getDateclose())).setTextAlignment(TextAlignment.LEFT).setFont(font).setFontSize(10));

                   table.addCell(cell1);
                   table.addCell(cell2);
                   table.addCell(cell3);
                   table.addCell(cell4);
                   table.addCell(cell5);
                   table.addCell(cell6);
                   i++;
               }
                document.add(table);
                document.close();
           }catch (IOException e){
               System.out.println(e);
           }
        return agreement.getName()+".pdf";
    }

    public HttpServletResponse downloadFile(String agreementId, HttpServletResponse response, String fileName) {
        Agreement agreement = agreementRepo.findById(Long.valueOf(agreementId)).get();
        String path = agreement.getPath();
        response = taskService.downloadFile(path,fileName,response);
        return response;
    }
}


