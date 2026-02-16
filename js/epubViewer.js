/**
 * @file plugins/generic/epubViewer/js/epubViewer.js
 *
 * Copyright (c) 2010-2021 Lepidus Tecnologia
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * JavaScript for EPUB Viewer using Epub.js
 */

(function() {
	'use strict';

	window.initEpubViewer = function(epubUrl) {
		$(document).ready(function() {
			if (typeof JSZip === 'undefined') {
				$('#epub-viewer').html('<div style="padding: 20px; text-align: center;">Error al cargar las librerías necesarias. Por favor, intente nuevamente.</div>');
				return;
			}
			
			if (typeof ePub === 'undefined') {
				$('#epub-viewer').html('<div style="padding: 20px; text-align: center;">Error al cargar el visor de EPUB. Por favor, intente nuevamente.</div>');
				return;
			}

			epubUrl = epubUrl + (epubUrl.indexOf('?') > -1 ? '&' : '?') + 'inline=true';

			$('#epub-area').html('<div style="padding: 40px; text-align: center; color: #666;"><div style="font-size: 18px; margin-bottom: 10px;">Cargando EPUB...</div><div>Por favor espere</div></div>');

			fetch(epubUrl, {
				method: 'GET',
				credentials: 'same-origin',
				headers: {
					'Accept': 'application/epub+zip, application/octet-stream'
				}
			})
			.then(function(response) {
				if (!response.ok) {
					throw new Error('Error al descargar el archivo: ' + response.statusText);
				}
				return response.blob();
			})
			.then(function(blob) {
				return blob.arrayBuffer();
			})
			.then(function(arrayBuffer) {
				$('#epub-area').empty();
				
				var book = ePub(arrayBuffer);
				
				var rendition = book.renderTo("epub-area", {
					width: "100%",
					height: "100%",
					spread: "always",
					flow: "paginated",
					allowScriptedContent: true
				});

				return rendition.display().then(function() {
					$('#prev-btn').on('click', function() {
						rendition.prev();
					});

					$('#next-btn').on('click', function() {
						rendition.next();
					});

					$(document).on('keydown', function(e) {
						if (e.keyCode === 37) {
							rendition.prev();
						} else if (e.keyCode === 39) {
							rendition.next();
						}
					});

					book.ready.catch(function(error) {
						$('#epub-viewer').html('<div style="padding: 20px; text-align: center;">Error al cargar el archivo EPUB. Detalles: ' + error.message + '</div>');
					});
				});
			})
			.catch(function(error) {
				$('#epub-viewer').html('<div style="padding: 20px; text-align: center;"><strong>Error al cargar el archivo EPUB</strong><br><br>El archivo puede estar corrupto o en un formato no compatible.<br><br>Detalles: ' + error.message + '</div>');
			});
		});
	};
})();
