<div id="wrapper">

    <div id="page-wrapper">

        <h1>Create a Quiz</h1>
        <p>To Create a Quiz please fill out the information below.</p>

        <form id="quiz-form" class="form-horizontal" onSubmit="return createQuiz();">
            <fieldset>

                <!-- Form Name -->
                <legend></legend>

                <!-- Select Basic -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="category">Quest Category</label>
                    <div class="col-md-8">
                        <select id="category" name="category" class="form-control">
                            <option value="1">Helping Children</option>
                            <option value="2">Giving Food</option>
                            <option value="3">Donating Time</option>
                            <option value="4">Health Care</option>
                            <option value="5">Volunteer</option>
                            <option value="6">Teaching</option>
                            <option value="7">Donation</option>
                        </select>
                    </div>
                </div>

                <!-- Textarea -->
<div class="form-group">
  <label class="col-md-4 control-label" for="question">Quest Question</label>
  <div class="col-md-8">                     
    <textarea class="form-control" id="question" name="question"></textarea>
  </div>
</div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="answer_a">Answer A:</label>  
                    <div class="col-md-8">
                        <input id="answer_a" name="answer_a" type="text" placeholder="Limits to 50 characters" class="form-control input-md">

                    </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="answer_b">Answer B:</label>  
                    <div class="col-md-8">
                        <input id="answer_b" name="answer_b" type="text" placeholder="Limits to 50 characters" class="form-control input-md">

                    </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="answer_c">Answer C:</label>  
                    <div class="col-md-8">
                        <input id="answer_c" name="answer_c" type="text" placeholder="Limits to 50 characters" class="form-control input-md">

                    </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="answer_d">Answer D:</label>  
                    <div class="col-md-8">
                        <input id="answer_d" name="answer_d" type="text" placeholder="Limits to 50 characters" class="form-control input-md">

                    </div>
                </div>

                <!-- Multiple Radios (inline) -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="answer">Correct Answer</label>
                    <div class="col-md-8"> 
                        <label class="radio-inline" for="answer-0">
                            <input type="radio" name="answer" id="answer-0" value="0" checked="checked">
                            A
                        </label> 
                        <label class="radio-inline" for="answer-1">
                            <input type="radio" name="answer" id="answer-1" value="1">
                            B
                        </label> 
                        <label class="radio-inline" for="answer-2">
                            <input type="radio" name="answer" id="answer-2" value="2">
                            C
                        </label> 
                        <label class="radio-inline" for="answer-3">
                            <input type="radio" name="answer" id="answer-3" value="3">
                            D
                        </label>
                    </div>
                </div>

                <!-- Textarea -->
<div class="form-group">
  <label class="col-md-4 control-label" for="sharing">Sharing Information</label>
  <div class="col-md-8">                     
    <textarea class="form-control" id="sharing" name="sharing">Write down a fact related to the question you would like the user to share. Limit to 140 characters.</textarea>
  </div>
</div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="link">More Link URL</label>  
                    <div class="col-md-8">
                        <input id="link" name="link" type="text" placeholder="Website URL for learning more" class="form-control input-md">

                    </div>
                </div>

                <!-- Button -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="submit"></label>
                    <div class="col-md-8">
                        <button id="submit" name="submit" class="btn btn-primary">Submit Quiz</button>
                        <div id="alert_placeholder"></div>
                    </div>
                </div>

            </fieldset>
        </form>


    </div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->