<!-- <button class="btn btn-facebook"><i class="fa fa-facebook"></i> | Login with Facebook</button> -->

<?php echo form_open('login', array('class' => 'form-signin')) ?>

<h2 class="form-signin-heading">Please sign in</h2>

<div class="form-group <?php echo (form_error('identity')) ? 'error' : '' ?>">
    <div class="controls">
        <label for="identity" class="control-label">Email</label>
        <?php echo form_input($identity) ?>
        <?php echo form_error('identity') ?>
    </div>
</div>

<div class="form-group <?php echo (form_error('password')) ? 'error' : '' ?>">
    <div class="controls">
        <label for="password" class="control-label">Password</label>
        <?php echo form_input($password) ?>
        <?php echo form_error('password') ?>
    </div>
</div>


<div class="checkbox">
    <label class="cb_rememberme">
        <?php echo form_checkbox('remember', '1', FALSE, 'id="remember"') ?> Keep me logged in
    </label>
</div>
<button id="btn_submit" class="btn tn-larbge btn-primary" type="submit">Log In</button>

<?php echo form_close() ?>

<div class="section_forgot">
    &raquo; <a href="<?php echo site_url('forgot-password') ?>">Forgot your password?</a>
</div>