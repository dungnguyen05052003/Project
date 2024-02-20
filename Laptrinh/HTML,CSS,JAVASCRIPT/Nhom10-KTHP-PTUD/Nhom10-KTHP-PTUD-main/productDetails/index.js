
    function toast({
        title='',
        message='',
        type='info',
        duration=3000
    }){
        const main= document.getElementById('toast');
        if(main){
            const toast = document.createElement('div');
            toast.onclick = function(e){
                if(e.target.closest('.toast__close')){
                    main.removeChild(toast);
                }
            }
            const delay =(duration/1000).toFixed(2);
            toast.classList.add('toast', `toast--${type}`);
            toast.style.animation=` slideInLeft ease 0.3s, fadeout linear 1s ${delay}s forwards`
            toast.innerHTML=`
        <div class="toast toast--success">
              <div class="toast__icon">
                <i class="fa-solid fa-square-check"></i>
              </div>
              <div class="toast__body">
                <h3 class="toast__title">${title}</h3>
                <p class="toast__msg">${message}</p>
              </div>
              <div class="toast__close">
                <i class="fa-solid fa-xmark"></i>
              </div>
        </div>
            `;
            main.appendChild(toast);
            setTimeout(function(){
                main.removeChild(toast);
            },duration+1000);
        }
    }
    function showsuccess(){
    toast({
        title:'Success',
        message:'Sản phẩm đã được thêm vào giỏ hàng',
        type:'success',
        duration:5000
    });
}
 