{**
 * plugins/generic/epubViewer/templates/submissionGalley.tpl
 *
 * Copyright (c) 2010-2021 Lepidus Tecnologia
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Embedded viewing of a EPUB galley.
 *}
{capture assign="epubUrl"}{strip}
	{if $isLatestPublication}
		{url op="download" path=$bestId|to_array:$galley->getBestGalleyId():$galleyFile->getId() escape=false}
	{else}
		{url op="download" path=$bestId|to_array:'version':$galleyPublication->getId():$galley->getBestGalleyId():$galleyFile->getId() escape=false}
	{/if}
{/strip}{/capture}
{capture assign="parentUrl"}{url page=$submissionNoun op="view" path=$bestId}{/capture}
{capture assign="galleyTitle"}{translate key="submission.representationOfTitle" representation=$galley->getLabel() title=$galleyPublication->getLocalizedFullTitle()|escape}{/capture}
{capture assign="datePublished"}{translate key="submission.outdatedVersion" datePublished=$galleyPublication->getData('datePublished') urlRecentVersion=$parentUrl}{/capture}
{include file=$displayTemplateResource title=$galleyPublication->getLocalizedTitle(null, 'html') parentUrl=$parentUrl epubUrl=$epubUrl galleyTitle=$galleyTitle datePublished=$datePublished parent=$issue isTitleHtml=true}
