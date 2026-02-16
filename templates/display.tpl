{**
 * plugins/generic/epubViewer/templates/display.tpl
 *
 * Copyright (c) 2010-2021 Lepidus Tecnologia
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Embedded viewing of a EPUB galley.
 *
 * @hook Templates::Common::Footer::PageFooter []
 *}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	{$application = Application::get()}
	<title>
		{if $application->getName() === 'omp'}
			{if $isTitleHtml}
				{translate key="catalog.viewableFile.title" type=$publicationFormat->getLocalizedName()|escape title=$title|strip_tags|escape}
			{else}
				{translate key="catalog.viewableFile.title" type=$publicationFormat->getLocalizedName()|escape title=$title|escape}
			{/if}
		{else}
			{if $isTitleHtml}
				{translate key="article.pageTitle" title=$title|strip_tags|escape}
			{else}
				{translate key="article.pageTitle" title=$title|escape}
			{/if}
		{/if}
	</title>

	{load_header context="frontend" headers=$headers}
	{load_stylesheet context="frontend" stylesheets=$stylesheets}
	{load_script context="frontend" scripts=$scripts}
	<link rel="stylesheet" href="{$pluginUrl}/vendor/bibi/bibi/bibi/resources/styles/bibi.css" />
</head>

<body class="pkp_page_{$requestedPage|escape} pkp_op_{$requestedOp|escape}">

	{if $application->getName() == 'omp'}
		{* Header wrapper *}
		<header class="header_viewable_file">

			<a href="{$parentUrl}" class="return">
				<span class="pkp_screen_reader">
					{translate key="catalog.viewableFile.return" monographTitle=$publishedSubmission->getLocalizedTitle()|escape}
				</span>
			</a>

			<a href="{$parentUrl}" class="title">
				{if $isTitleHtml}
					{$title|strip_unsafe_html}
				{else}
					{$title|escape}
				{/if}
			</a>

			<a href="{$downloadUrl|escape}" class="download" download>
				<span class="label">
					{translate key="common.download"}
				</span>
				<span class="pkp_screen_reader">
					{translate key="common.downloadPdf"}
				</span>
			</a>

		</header>
	{else}
		{* Header wrapper *}
		<header class="header_view">
			<a href="{$parentUrl}" class="return">
				<span class="pkp_screen_reader">
					{if $parent instanceOf Issue}
						{translate key="issue.return"}
					{else}
						{translate key="article.return"}
					{/if}
				</span>
			</a>

			<a href="{$parentUrl}" class="title">
				{if $isTitleHtml}
					{$title|strip_unsafe_html}
				{else}
					{$title|escape}
				{/if}
			</a>

			<a href="{$epubUrl}" class="download" download>
				<span class="label">
					{translate key="common.download"}
				</span>
				<span class="pkp_screen_reader">
					{translate key="common.downloadPdf"}
				</span>
			</a>

		</header>
	{/if}

	<div id="epubCanvasContainer" class="galley_view{if !$isLatestPublication} galley_view_with_notice{/if}">
		{if !$isLatestPublication}
			<div class="galley_view_notice">
				<div class="galley_view_notice_message" role="alert">
					{$datePublished}
				</div>
			</div>
		{/if}
	</div>

	<script src="{$pluginUrl}/vendor/bibi/bibi/bibi/and/jo.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {ldelim} 
			const Jo = window['bibi:jo'];
			
			if (!Jo) {
				console.error('Bibi library (jo.js) failed to load');
				return;
			}
			
			var urlBase = "{$pluginUrl}/vendor/bibi/bibi/bibi/index.html?book=";

			var epubUrl;
			{if $application->getName() === "omp"}
				epubUrl = {$downloadUrl|json_encode} + ".epub";
			{else} 
				epubUrl = {$epubUrl|json_encode} + "/file.epub";
			{/if}

			const OneMoreBibi = new Jo.Bibi({
				'bibi-href': urlBase + encodeURIComponent(epubUrl),
				'bibi-style': 'width: 100%; height: 480px;',
				'bibi-view': 'paged',
				'bibi-view-unchangeable': 'yes',
				'bibi-autostart': 'yes',
				'bibi-receive': ['bibi:flipped', 'bibi:got-to-the-beginning', 'bibi:got-to-the-end']
			});
			
			$("body").append(OneMoreBibi.Frame);
			$(".bibi-frame").css("height","97vh");
			
		{rdelim});
	</script>
	{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
