var PageTransitions = (function() {

	var $pages = $( '.phase' ),
		$iterate = $( '.phase' ),
		animcursor = 1,
		pagesCount = $pages.length,
		current = 0,
		isAnimating = false,
		endCurrPage = false,
		endNextPage = false,
		animEndEventNames = {
			'WebkitAnimation' : 'webkitAnimationEnd',
			'OAnimation' : 'oAnimationEnd',
			'msAnimation' : 'MSAnimationEnd',
			'animation' : 'animationend'
		},
		// animation end event name
		// animEndEventName = animEndEventNames[ Modernizr.prefixed( 'animation' ) ],
		animEndEventName = 'webkitAnimationEnd',
		// support css animations
		// support = Modernizr.cssanimations;
		support = true,
		parentwindow;

	function init(win) {

		parentwindow = win;

		$pages.each( function() {
			var $page = $( this );
			$page.data( 'originalClassList', $page.attr( 'class' ) );
		} );

		$pages.eq( current ).addClass( 'current' );

		// $( '#dl-menu' ).dlmenu( {
		// 	animationClasses : { in : 'dl-animate-in-2', out : 'dl-animate-out-2' },
		// 	onLinkClick : function( el, ev ) {
		// 		ev.preventDefault();
		// 		nextPage( el.data( 'animation' ) );
		// 	}
		// } );

		$iterate.on( 'click', function() {
			if( isAnimating ) {
				return false;
			}
			if( animcursor > 3 ) {
				animcursor = 1;
			}
			nextPage( animcursor );
			++animcursor;
		} );

	}

	function nextPage(options) {
		var animation = (options.animation) ? options.animation : options;

		if( isAnimating ) {
			return false;
		}

		if (parentwindow) {
			parentwindow.window.changeparentmethod();
		};

		isAnimating = true;

		var $currPage = $pages.eq( current );

		if(options.showPage){
			if( options.showPage < pagesCount - 1 ) {
				current = options.showPage;
			}
			else {
				current = 0;
			}
		}
		else{
			if( current < pagesCount - 1 ) {
				++current;
			}
			else {
				current = 0;
			}
		}

		var $nextPage = $pages.eq( current ).addClass( 'current' ),
			outClass = '', inClass = '';

		// outClass = 'pt-page-moveToLeft';
		// inClass = 'pt-page-moveFromRight';

		outClass = 'moveToLeftEasing ontop';
		inClass = 'moveFromRight';

		// outClass = 'pt-page-scaleDown';
		// inClass = 'pt-page-moveFromRight pt-page-ontop';

		// outClass = 'pt-page-fade';
		// inClass = 'pt-page-moveFromRight pt-page-ontop';

		// outClass = 'pt-page-moveToLeftFade';
		// inClass = 'pt-page-moveFromRightFade';

		// outClass = 'pt-page-scaleDown';
		// inClass = 'pt-page-scaleUpDown pt-page-delay300';


		$currPage.addClass( outClass ).on( animEndEventName, function() {
			$currPage.off( animEndEventName );
			endCurrPage = true;
			if( endNextPage ) {
				onEndAnimation( $currPage, $nextPage );
			}
		} );

		$nextPage.addClass( inClass ).on( animEndEventName, function() {
			$nextPage.off( animEndEventName );
			endNextPage = true;
			if( endCurrPage ) {
				onEndAnimation( $currPage, $nextPage );
			}
		} );

		if( !support ) {
			onEndAnimation( $currPage, $nextPage );
		}

	}

	function onEndAnimation( $outpage, $inpage ) {
		endCurrPage = false;
		endNextPage = false;
		resetPage( $outpage, $inpage );
		isAnimating = false;
	}

	function resetPage( $outpage, $inpage ) {
		$outpage.attr( 'class', $outpage.data( 'originalClassList' ) );
		$inpage.attr( 'class', $inpage.data( 'originalClassList' ) + ' current' );
	}

	return {
		init : init,
		nextPage : nextPage,
	};

})();
