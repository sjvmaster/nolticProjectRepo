/**
 * Created by Ivan.Sokolov on 12.01.2022.
 */

public with sharing class MorningCaseCreatorScheduler implements Schedulable {
    public void execute(SchedulableContext ctx) {
        String currentDateStr = Datetime.now().format('DD/MM/YYYY');
        try {
            insert new Case(Subject='Morning Case - ' + currentDateStr);
        }
        catch (Exception e){
            System.debug(e.getMessage());
        }
    }

    public void setupSchedulingJob(){
        String sch = '0 0 7 * * ?';
        String jobID = System.schedule('MorningCaseCreatorSchedulerJob', sch, this);
        System.debug('Scheduled: ' + jobID);
    }
}