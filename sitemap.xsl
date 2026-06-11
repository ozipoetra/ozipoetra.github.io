<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
        version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:image="http://www.google.com/schemas/sitemap-image/1.1"
        xmlns:video="http://www.google.com/schemas/sitemap-video/1.1"
        xmlns:xhtml="http://www.w3.org/1999/xhtml">

    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title>
                    Sitemap
                    <xsl:if test="sitemap:sitemapindex"> Index</xsl:if>
                </title>
                <style>
                    :root {
                        --bg: #0f172a;
                        --surface: #1e293b;
                        --surface-hover: #334155;
                        --border: #334155;
                        --text: #e2e8f0;
                        --text-muted: #94a3b8;
                        --primary: #38bdf8;
                        --primary-hover: #7dd3fc;
                        --accent: #818cf8;
                        --accent-hover: #a5b4fc;
                        --success: #34d399;
                        --warning: #fbbf24;
                        --danger: #f87171;
                        --gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    }

                    @media (prefers-color-scheme: light) {
                        :root {
                            --bg: #f8fafc;
                            --surface: #ffffff;
                            --surface-hover: #f1f5f9;
                            --border: #e2e8f0;
                            --text: #0f172a;
                            --text-muted: #64748b;
                            --primary: #0284c7;
                            --primary-hover: #0369a1;
                            --accent: #6366f1;
                            --accent-hover: #4f46e5;
                            --success: #059669;
                            --warning: #d97706;
                            --danger: #dc2626;
                            --gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        }
                    }

                    * { margin: 0; padding: 0; box-sizing: border-box; }

                    body {
                        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
                        background: var(--bg);
                        color: var(--text);
                        line-height: 1.6;
                        min-height: 100vh;
                    }

                    .container {
                        max-width: 1200px;
                        margin: 0 auto;
                        padding: 2rem 1rem;
                    }

                    header {
                        background: var(--gradient);
                        border-radius: 16px;
                        padding: 2.5rem;
                        margin-bottom: 2rem;
                        color: white;
                        position: relative;
                        overflow: hidden;
                    }

                    header::before {
                        content: '';
                        position: absolute;
                        top: -50%;
                        right: -50%;
                        width: 100%;
                        height: 100%;
                        background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
                        pointer-events: none;
                    }

                    .header-content {
                        position: relative;
                        z-index: 1;
                    }

                    .title-row {
                        display: flex;
                        align-items: center;
                        gap: 1rem;
                        flex-wrap: wrap;
                    }

                    h1 {
                        font-size: 2rem;
                        font-weight: 700;
                        margin: 0;
                        letter-spacing: -0.025em;
                    }

                    .badge {
                        display: inline-flex;
                        align-items: center;
                        padding: 0.35rem 0.75rem;
                        border-radius: 9999px;
                        font-size: 0.75rem;
                        font-weight: 600;
                        text-transform: uppercase;
                        letter-spacing: 0.05em;
                        background: rgba(255,255,255,0.2);
                        backdrop-filter: blur(4px);
                    }

                    .stats {
                        margin-top: 1.5rem;
                        font-size: 1.1rem;
                        opacity: 0.95;
                    }

                    .stats strong {
                        font-weight: 700;
                        text-decoration: underline;
                        text-decoration-color: rgba(255,255,255,0.5);
                        text-underline-offset: 3px;
                    }

                    .description {
                        margin-top: 0.75rem;
                        font-size: 0.9rem;
                        opacity: 0.85;
                    }

                    .description a {
                        color: white;
                        font-weight: 500;
                    }

                    .description a:hover {
                        text-decoration: underline;
                    }

                    .table-wrapper {
                        background: var(--surface);
                        border-radius: 12px;
                        border: 1px solid var(--border);
                        overflow: hidden;
                        box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -2px rgba(0,0,0,0.1);
                    }

                    table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    thead {
                        background: var(--surface);
                        border-bottom: 2px solid var(--border);
                    }

                    th {
                        padding: 1rem 1.25rem;
                        text-align: left;
                        font-size: 0.75rem;
                        font-weight: 700;
                        text-transform: uppercase;
                        letter-spacing: 0.05em;
                        color: var(--text-muted);
                    }

                    th.right { text-align: right; }

                    td {
                        padding: 1rem 1.25rem;
                        border-bottom: 1px solid var(--border);
                        font-size: 0.9rem;
                    }

                    tr:last-child td {
                        border-bottom: none;
                    }

                    tbody tr:hover {
                        background: var(--surface-hover);
                    }

                    .row-number {
                        width: 50px;
                        color: var(--text-muted);
                        font-weight: 600;
                        font-variant-numeric: tabular-nums;
                    }

                    .url-cell {
                        word-break: break-all;
                    }

                    .url-cell a {
                        color: var(--primary);
                        text-decoration: none;
                        font-weight: 500;
                        transition: color 0.15s ease;
                    }

                    .url-cell a:hover {
                        color: var(--primary-hover);
                        text-decoration: underline;
                    }

                    .changefreq {
                        text-transform: capitalize;
                        font-weight: 500;
                    }

                    .priority {
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        min-width: 3rem;
                        padding: 0.25rem 0.5rem;
                        border-radius: 6px;
                        font-weight: 600;
                        font-size: 0.85rem;
                    }

                    .priority-high {
                        background: rgba(52, 211, 153, 0.15);
                        color: var(--success);
                    }

                    .priority-medium {
                        background: rgba(251, 191, 36, 0.15);
                        color: var(--warning);
                    }

                    .priority-low {
                        background: rgba(248, 113, 113, 0.15);
                        color: var(--danger);
                    }

                    .lastmod {
                        color: var(--text-muted);
                        font-size: 0.85rem;
                        font-variant-numeric: tabular-nums;
                    }

                    .xhtml-links {
                        margin-top: 0.5rem;
                        padding-top: 0.5rem;
                        border-top: 1px dashed var(--border);
                    }

                    .xhtml-label {
                        font-size: 0.75rem;
                        font-weight: 600;
                        color: var(--text-muted);
                        text-transform: uppercase;
                        letter-spacing: 0.05em;
                        margin-bottom: 0.25rem;
                    }

                    .xhtml-link {
                        display: inline-flex;
                        align-items: center;
                        gap: 0.35rem;
                        margin: 0.15rem 0.25rem 0.15rem 0;
                        padding: 0.2rem 0.5rem;
                        background: var(--surface);
                        border: 1px solid var(--border);
                        border-radius: 6px;
                        font-size: 0.75rem;
                        color: var(--text-muted);
                        text-decoration: none;
                        transition: all 0.15s ease;
                    }

                    .xhtml-link:hover {
                        background: var(--surface-hover);
                        border-color: var(--accent);
                        color: var(--accent);
                    }

                    .hreflang-badge {
                        display: inline-flex;
                        align-items: center;
                        padding: 0.15rem 0.4rem;
                        background: var(--accent);
                        color: white;
                        border-radius: 4px;
                        font-size: 0.65rem;
                        font-weight: 700;
                        text-transform: uppercase;
                    }

                    footer {
                        margin-top: 2rem;
                        padding: 1.5rem;
                        text-align: center;
                        color: var(--text-muted);
                        font-size: 0.85rem;
                    }

                    footer a {
                        color: var(--primary);
                        text-decoration: none;
                    }

                    footer a:hover {
                        text-decoration: underline;
                    }

                    @media (max-width: 768px) {
                        .container { padding: 1rem; }
                        header { padding: 1.5rem; }
                        h1 { font-size: 1.5rem; }
                        th, td { padding: 0.75rem; font-size: 0.8rem; }
                        .badge { font-size: 0.65rem; padding: 0.25rem 0.5rem; }
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <header>
                        <div class="header-content">
                            <div class="title-row">
                                <h1>Sitemap</h1>
                                <xsl:if test="sitemap:sitemapindex">
                                    <span class="badge">Index</span>
                                </xsl:if>
                                <xsl:if test="sitemap:urlset/sitemap:url/image:image">
                                    <span class="badge">Images</span>
                                </xsl:if>
                                <xsl:if test="sitemap:urlset/sitemap:url/video:video">
                                    <span class="badge">Video</span>
                                </xsl:if>
                                <xsl:if test="sitemap:urlset/sitemap:url/xhtml:link">
                                    <span class="badge">Xhtml</span>
                                </xsl:if>
                            </div>
                            <div class="stats">
                                <xsl:choose>
                                    <xsl:when test="sitemap:sitemapindex">
                                        This index contains
                                        <strong><xsl:value-of select="count(sitemap:sitemapindex/sitemap:sitemap)"/></strong>
                                        sitemaps.
                                    </xsl:when>
                                    <xsl:otherwise>
                                        This sitemap contains
                                        <strong><xsl:value-of select="count(sitemap:urlset/sitemap:url)"/></strong>
                                        URLs.
                                    </xsl:otherwise>
                                </xsl:choose>
                            </div>
                            <p class="description">
                                This is an XML sitemap, meant for consumption by search engines.<br/>
                                Learn more at <a href="https://sitemaps.org">sitemaps.org</a>.
                            </p>
                        </div>
                    </header>

                    <xsl:apply-templates/>
                </div>
            </body>
        </html>
    </xsl:template>


    <xsl:template match="sitemap:sitemapindex">
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th class="row-number">#</th>
                        <th>URL</th>
                        <th class="right">Last Modified</th>
                    </tr>
                </thead>
                <tbody>
                <xsl:for-each select="sitemap:sitemap">
                    <tr>
                        <xsl:variable name="loc">
                            <xsl:value-of select="sitemap:loc"/>
                        </xsl:variable>
                        <td class="row-number">
                            <xsl:value-of select="position()"/>
                        </td>
                        <td class="url-cell">
                            <a href="{$loc}">
                                <xsl:value-of select="sitemap:loc"/>
                            </a>
                        </td>
                        <xsl:if test="sitemap:lastmod">
                        <td class="right">
                            <span class="lastmod">
                                <xsl:value-of select="concat(substring(sitemap:lastmod, 0, 11), concat(' ', substring(sitemap:lastmod, 12, 5)), concat(' ', substring(sitemap:lastmod, 20, 6)))"/>
                            </span>
                        </td>
                        </xsl:if>
                        <xsl:apply-templates/>
                    </tr>
                </xsl:for-each>
                </tbody>
            </table>
        </div>
    </xsl:template>

    <xsl:template match="sitemap:urlset">
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th class="row-number">#</th>
                        <th>URL</th>
                        <xsl:if test="sitemap:url/sitemap:changefreq">
                        <th class="right">Change Freq.</th>
                        </xsl:if>
                        <xsl:if test="sitemap:url/sitemap:priority">
                        <th class="right">Priority</th>
                        </xsl:if>
                        <xsl:if test="sitemap:url/sitemap:lastmod">
                        <th class="right">Last Modified</th>
                        </xsl:if>
                    </tr>
                </thead>
                <tbody>
                <xsl:for-each select="sitemap:url">
                    <tr>
                        <xsl:variable name="loc">
                            <xsl:value-of select="sitemap:loc"/>
                        </xsl:variable>
                        <td class="row-number">
                            <xsl:value-of select="position()"/>
                        </td>
                        <td class="url-cell">
                            <a href="{$loc}">
                                <xsl:value-of select="sitemap:loc"/>
                            </a>
                            <xsl:apply-templates select="xhtml:*"/>
                            <xsl:apply-templates select="image:*"/>
                            <xsl:apply-templates select="video:*"/>
                        </td>
                        <xsl:apply-templates select="sitemap:changefreq"/>
                        <xsl:apply-templates select="sitemap:priority"/>
                        <xsl:if test="sitemap:lastmod">
                        <td class="right">
                            <span class="lastmod">
                                <xsl:value-of select="concat(substring(sitemap:lastmod, 0, 11), concat(' ', substring(sitemap:lastmod, 12, 5)), concat(' ', substring(sitemap:lastmod, 20, 6)))"/>
                            </span>
                        </td>
                        </xsl:if>
                    </tr>
                </xsl:for-each>
                </tbody>
            </table>
        </div>
    </xsl:template>

    <xsl:template match="sitemap:loc|sitemap:lastmod|image:loc|image:caption|video:*">
    </xsl:template>

    <xsl:template match="sitemap:changefreq">
        <td class="right">
            <span class="changefreq">
                <xsl:apply-templates/>
            </span>
        </td>
    </xsl:template>

    <xsl:template match="sitemap:priority">
        <td class="right">
            <xsl:choose>
                <xsl:when test=". &gt;= 0.9">
                    <span class="priority priority-high"><xsl:apply-templates/></span>
                </xsl:when>
                <xsl:when test=". &gt;= 0.7">
                    <span class="priority priority-medium"><xsl:apply-templates/></span>
                </xsl:when>
                <xsl:otherwise>
                    <span class="priority priority-low"><xsl:apply-templates/></span>
                </xsl:otherwise>
            </xsl:choose>
        </td>
    </xsl:template>

    <xsl:template match="xhtml:link">
        <div class="xhtml-links">
            <div class="xhtml-label">Alternate Languages</div>
            <xsl:variable name="altloc">
                <xsl:value-of select="@href"/>
            </xsl:variable>
            <a href="{$altloc}" class="xhtml-link">
                <xsl:if test="@hreflang">
                    <span class="hreflang-badge"><xsl:value-of select="@hreflang"/></span>
                </xsl:if>
                <xsl:value-of select="@href"/>
            </a>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="image:image">
        <div class="xhtml-links">
            <div class="xhtml-label">Image</div>
            <xsl:variable name="loc">
                <xsl:value-of select="image:loc"/>
            </xsl:variable>
            <a href="{$loc}" class="xhtml-link">
                <xsl:value-of select="image:loc"/>
            </a>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="video:video">
        <div class="xhtml-links">
            <div class="xhtml-label">Video</div>
            <xsl:variable name="loc">
                <xsl:choose>
                    <xsl:when test="video:player_loc != ''">
                        <xsl:value-of select="video:player_loc"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="video:content_loc"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <a href="{$loc}" class="xhtml-link">
                <xsl:choose>
                    <xsl:when test="video:player_loc != ''">
                        <xsl:value-of select="video:player_loc"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="video:content_loc"/>
                    </xsl:otherwise>
                </xsl:choose>
            </a>
            <xsl:if test="video:title">
                <span class="xhtml-link">
                    <xsl:value-of select="video:title"/>
                </span>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

</xsl:stylesheet>
