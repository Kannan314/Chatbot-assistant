<style>
	.q-item {
	    border-radius: 50px;
	}


</style>
<?php
if(isset($_GET['id']) && !empty($_GET['id'])){
	$qry = $conn->query("SELECT q.id, r.response_message, q.question FROM `questions` q inner join `responses` r on q.response_id = r.id where q.id = {$_GET['id']}");
	foreach($qry->fetch_array() as $k => $v){
		if(!is_numeric($k)){
			$$k = $v;
		}
	}
}
?>
<div class="card card-outline card-info">
	<div class="card-header">
		<h3 class="card-title"><?php echo isset($_GET['id']) ? "Update ": "Create New " ?>Question Response</h3>
	</div>
	<div class="card-body">
		<form action="" id="response-form">
			<input type="hidden" name ="id" value="<?php echo isset($_GET['id']) ? $_GET['id'] : '' ?>">
			<?php if(!isset($id)): ?>
			<div class="form-group">
				<label for="question_field" class="control-label">Question</label>
				<div class="input-group col-lg-6">
                    <input type="text" id="question" class="form-control form-control-sm" data-original-title="" title="">

                    <div class="input-group-append">
                      <a href="javascript:void(0)" class="input-group-text  bg-primary" id="add_question"><i class="fas fa-plus"></i></a>
                    </div>
                </div>
                <small><i>(Click the "<b>+</b>" to add the question)</i></small>
			</div>
			<?php else: ?>
				<div class="form-group">
					<label for="question_field" class="control-label">Question</label>
                    <input type="text" id="question_field" name="question[]" value="<?php echo isset($question) ? $question : '' ?>" class="form-control form-control-sm" required>
				</div>
			<?php endif; ?>
			<div class="form-group">
			<div class="continer-fluid" id="question-holder">
				<?php 

				if(isset($_GET['q']) && !empty($_GET['q'])){
				?>	
					<span class="badge badge-primary q-item m-2 pl-2">
						<span style='font-size:12px'><?php echo $_GET['q'] ?><input type='hidden' name='question[]' value='<?php echo $_GET['q'] ?>'></span>
						<span class='p-2'><a href='javascript:void(0)' onclick="$(this).closest('.q-item').remove();" class='text-white'><i class='fa fa-times'></i></a></span></span>
					</span>
				<script>
					$(document).ready(function(){
						$('#response_message').focus();
					})
				</script>
				<?php 
				}

				?>

			</div>
			</div>
			<div class="form-group">
				<label for="response_message" class="control-label">Response Message</label>
				<textarea name="response_message" id="response_message" cols="30" rows="3" class="form-control" style="resize: none" required><?php echo isset($response_message) ? $response_message : ''; ?></textarea>
			</div>
		</form>
	</div>
	<div class="card-footer">
		<button class="btn btn-flat btn-primary" form="response-form">Save</button>
		<a class="btn btn-flat btn-default" href="?page=responses">Cancel</a>
	</div>
</div>
<script>
	$(document).ready(function(){
		function add_question(){
			var question = $('#question').val()
			if(question == '' || question == null)
				return false;
			var span = $('<span class="badge badge-primary q-item m-2 pl-2"></span>')
			span.append("<span style='font-size:12px'>"+question+"<input type='hidden' name='question[]' value='"+question+"'></span>")
			span.append("<span class='p-2'><a href='javascript:void(0)' onclick=\"$(this).closest('.q-item').remove();\" class='text-white'><i class='fa fa-times'></i></a></span></span>")
			span.appendTo('#question-holder');
			 $('#question').val('')
			 $('#question').removeClass("border-danger")
			 $('.err-msg').remove();
			 $('#question').focus();
		}
		$('#add_question').click(function(){
			add_question()
		})
		$('#question').keypress(function(e){
			if(e.which === 13){
			add_question()
			return false;
			}
		})
		$('#response-form').submit(function(e){
			e.preventDefault();
			 $('.err-msg').remove();
			if($('input[name="question[]"]').length <= 0){
				$('#question').addClass("border-danger")
				$('#question-holder').after("<span class='alert alert-danger err-msg'><i class='fa fa-exclamation-triangle'></i>  You must add atleast one (1) possible question for the response.</span>")
				$('#question').focus();
				return false;
			}
			start_loader();
			$.ajax({
				url:_base_url_+"classes/Master.php?f=save_response",
				method:'POST',
				data:$(this).serialize(),
				error:err=>{
					console.log(err)
					alert_toast("An error occured",'error');
					end_loader();
				},
				success:function(resp){
					if(resp == 1){
						location.href = "./?page=responses";
					}else{
						alert_toast("An error occured",'error');
						end_loader();
					}
				}
			})
		})
	})
</script>