<div id="wrapper">

    <div id="page-wrapper">

        <h1>Edit a Quiz</h1>
        <p>You can edit the Quiz to be more accurate.</p>
        <div class="col-lg-8">
            <form class="form-horizontal">
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

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="question">Quest Question</label>  
                        <div class="col-md-8">
                            <input id="question" name="question" type="text" placeholder="Limits to 140 character" class="form-control input-md" required="">

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

                    <!-- Multiple Checkboxes (inline) -->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="correct_answer">Correct Answer</label>
                        <div class="col-md-8">
                            <label class="checkbox-inline" for="correct_answer-0">
                                <input type="checkbox" name="correct_answer" id="correct_answer-0" value="1">
                                A
                            </label>
                            <label class="checkbox-inline" for="correct_answer-1">
                                <input type="checkbox" name="correct_answer" id="correct_answer-1" value="2">
                                B
                            </label>
                            <label class="checkbox-inline" for="correct_answer-2">
                                <input type="checkbox" name="correct_answer" id="correct_answer-2" value="3">
                                C
                            </label>
                            <label class="checkbox-inline" for="correct_answer-3">
                                <input type="checkbox" name="correct_answer" id="correct_answer-3" value="4">
                                D
                            </label>
                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="sharing">Sharing Information</label>  
                        <div class="col-md-8">
                            <input id="sharing" name="sharing" type="text" placeholder="Write down a fact related to the question you would like the user to share. Limit to 140 characters." class="form-control input-md">

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
                        </div>
                    </div>

                </fieldset>
            </form> <!-- End of form 1 -->
        </div>

        <div class="col-lg-4 left-border">
            <form class="" role="form">
                <fieldset>

                    <!-- Form Name -->
                    <legend></legend>

                    <!-- Select Basic -->
                    <div class="form-group">
                        <label class=" control-label" for="packet">Packet:</label>
                        <div class="">
                            <select id="packet" name="packet" class="form-control">
                                <option value="1">Ho Chi Minh City</option>
                                <option value="2">Ha Noi</option>
                                <option value="3">Da Nang</option>
                                <option value="4">Binh Duong</option>
                            </select>
                        </div>
                    </div>

                    <!-- Button (Double) -->
                    <div class="form-group">
                        <label class=" control-label" for="approve">Approve:</label>
                        <div class="">
                            <button id="approve" name="approve" class="btn  btn-success">Yes</button>
                            <button id="deny" name="deny" class="btn  btn-danger">No</button>
                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class=" control-label" for="date">Published on:</label>  
                        <div class="">
                            <input id="date" name="date" type="text" placeholder="YYYY/MM/DD" class="form-control input-md">

                        </div>
                    </div>

                    <hr class ="hr-blue">
                    <!-- Button -->
                    <div class="form-group">
                        <label class=" control-label" for="delete"></label>
                        <div class="">
                            <button id="delete" name="delete" class="btn btn-block btn-danger">Delete Question</button>
                        </div>
                    </div>

                </fieldset>
            </form>
        </div>


    </div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->