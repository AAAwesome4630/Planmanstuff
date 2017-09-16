class ScheduleController < ApplicationController
    
    def student_schedule(weekend_settings)

        @json_string_start = "{\"assignments\":[],"
        @json_string_tests = " \"tests\":[],"
        @json_string_quizzes = " \"quizzes\":[],"
        @json_string_end = "}"
        @individual_assignments = current_student.individual_assignments.all
        @individual_tests = current_student.individual_tests.all
        @individual_quizzes = current_student.individual_quizzes.all
        if(weekend == "normal")
            for assignment in @individual_assignments do
              if !(assignment.finished)
                @time = adays_btwn(assignment)
                if !(@time==false)
                  @json_string_start = @json_string_start + "[\"assignment_id\":" + assignment.id + "\", \"assignment_name\":\"" + assignment.name + "\", \"recommended time\":" + @time.to_s + "],"
                end
              end
            end
            for atest in @individual_tests do
              if !(test.finished)
                @time = tqdays_btwn(atest)
                if !(@time==false)
                  @json_string_test = @json_string_test + "[\"test_id\":" + atest.id + "\", test_name\":\"" + atest.name + "\", \"recommended time\":" + @time.to_s + "],"
                end
              end
            end
            for quiz in @individual_quizzes do
              if !(quiz.finished)
                @time = tqdays_btwn(quiz)
                if !(@time==false)
                  @json_string_quiz = @json_string_quiz + "[\"quiz_id\":" + quiz.id + "\", quiz_name\":\"" + quiz.name + "\", \"recommended time\":" + @time.to_s + "],"
                end
              end
            end
            @json_string = @json_string_start + @json_string_test + @json_string_quizzes + @json_string_end
          return @json_string 
        end
    end
    
    
    def adays_btwn(assignment)
      @dif = (assignemnt.due_date.to_s - Date.today.to_s)
      if(@dif <= assignment.rec_days)
        assignment.rec_days = @dif
        assignment.save
        @time = assignment.time_remaining/assignment.rec_days
        return @time
      else
        return false
      end
    end
    def tqdays_btwn(quiz)
      @dif = (quiz.date.to_s - Date.today.to_s)
      if(@dif <= quiz.rec_days)
        quiz.rec_days = @dif
        quiz.save
        @time = quiz.time_remaining/quiz.rec_days
        return @time
      else
        return false
      end
    end
    
    
end
    
    
    
