<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.w3.org/1999/xhtml" >

<xsl:output method="html" encoding="UTF-8" indent="yes" />


	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="cartoline.css" />
				<script src="cartoline.js"></script>
				<title>Cartoline</title>
			</head>
			<!--struttura base del sito-->
			<body>
				<!--riquadri informazioni generali-->
				<xsl:apply-templates select="//tei:titleStmt[@xml:id='titleStmt']"/>
				<div class="riquadri">
					<xsl:apply-templates select="//tei:editionStmt[@xml:id='editionStmt']"/>
				</div>
				<div class="riquadri">
					<xsl:apply-templates select="//tei:publicationStmt[@xml:id='publicationStmt']"/>
				</div>
				<!--singole cartoline-->
				<div id="contenitoreCartoline">
					<div class="cartoline" id="cartolina108">
						<xsl:apply-templates select="//tei:TEI[@xml:id='cartolina108']"/>
					</div>

					<div class="cartoline" id="cartolina218">
						<xsl:apply-templates select="//tei:TEI[@xml:id='cartolina218']"/>
					</div>

					<div class="cartoline" id="cartolina182">
						<xsl:apply-templates select="//tei:TEI[@xml:id='cartolina182']"/>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>

	<!--titolo e riquadro informazioni generali-->
	<xsl:template match="//tei:titleStmt[@xml:id='titleStmt']">
		<h1><xsl:value-of select="tei:title" /></h1>
		<div class="riquadri">
			<h2>Informazioni generali:</h2>
			<xsl:apply-templates select="tei:respStmt"/>
			<xsl:apply-templates select="//tei:msDesc[@xml:id='msDesc']"/>
		</div>
	</xsl:template>

	<!--lista responsabilità-->
	<xsl:template match="//tei:respStmt">
		<h3>
			<xsl:value-of select="tei:resp" />
		</h3>
		<ul>
            <xsl:for-each select="tei:name">
                <li><xsl:value-of select="."/></li>     
            </xsl:for-each>
        </ul>
	</xsl:template>

	<!--riquadro edizione digitale-->
	<xsl:template match="//tei:editionStmt">
		<h2>Edizione digitale:</h2>
        <p><xsl:value-of select="tei:edition"/></p>
        <xsl:apply-templates select="tei:respStmt"/>
    </xsl:template>

	<!--riquadro pubblicazione-->
	<xsl:template match="//tei:publicationStmt">
		<h2>Pubblicazione:</h2>
		<p><xsl:value-of select="tei:publisher"/>, 
			<xsl:value-of select="tei:pubPlace"/>, 
			<xsl:value-of select="tei:distributor"/>, 
			<xsl:value-of select="tei:address/tei:addrLine"/>.
		</p>
		<p>
			<xsl:value-of select="tei:availability"/>, 
			<xsl:value-of select="tei:date"/>.
		</p>
	</xsl:template>

	<!--note (in dettagli manoscritto)-->
	<xsl:template match="//tei:notesStmt">
		<p>Note: <xsl:value-of select="."/></p>
	</xsl:template>

	<!--collocazione (in informazioni generali)-->
	<xsl:template match="//tei:msDesc[@xml:id='msDesc']">
		<h3>Collocazione dei manoscritti:</h3>
		<p>
			<xsl:value-of select="//tei:msIdentifier/tei:country"/>, 
			<xsl:value-of select="//tei:msIdentifier/tei:settlement"/>, 
			<xsl:value-of select="//tei:msIdentifier/tei:repository"/>.
		</p>
	</xsl:template>

	<!--dettagli manoscritto ed eventuali note-->
	<xsl:template match="//tei:sourceDesc"> 
		<div class="dettCartolina">
			<h3>Dettagli manoscritto:</h3>
			<p>Codice identificativo: <xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:idno"/></p>
			<p>Dimensioni: <xsl:value-of select="tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:material"/>, <xsl:value-of select="tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:dimensions/tei:height"/> x <xsl:value-of select="tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:dimensions/tei:width"/> </p>
			<p>Condizione: <xsl:value-of select="tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:condition"/></p>
			<xsl:apply-templates select="current()/parent::tei:fileDesc/tei:notesStmt"/>
		</div>
	</xsl:template>

	<!--lista persone-->
	<xsl:template match="//tei:listPerson">
		<h3>Persone Citate:</h3>
		<ul>
            <xsl:for-each select="tei:person">
                <li>
					<xsl:value-of select="tei:persName"/> 
					(<xsl:value-of select="tei:sex"/>) 
					</li>     
            </xsl:for-each>
        </ul>
	</xsl:template>

	<!--lista luoghi-->
	<xsl:template match="//tei:listPlace">
		<h3>Luoghi Citati:</h3>
		<ul>
            <xsl:for-each select="tei:place">
                <li>
					<xsl:value-of select="tei:placeName"/> 
					(<xsl:value-of select="tei:district[@type='provincia']"/>), 
					<xsl:value-of select="tei:country"/>
				 </li>     
            </xsl:for-each>
        </ul>
	</xsl:template>

	<!--dettagli corrispondenza-->
	<xsl:template match="//tei:profileDesc">
		<xsl:for-each select="tei:correspDesc/tei:correspAction">
			<xsl:if test="@type='sent'" ><h3>Spedita da:</h3></xsl:if>
			<xsl:if test="@type='received'" ><h3>Inviata a:</h3></xsl:if>
			<p><xsl:value-of select="tei:persName"/></p> 
			<p><xsl:value-of select="tei:placeName"/></p>
			<p><xsl:value-of select="tei:date"/></p>
		</xsl:for-each>
	</xsl:template>

	<!--titolo singlole cartoline-->
	<xsl:template match="//tei:text">
		<h1><xsl:value-of select="tei:body/tei:div/tei:figure/tei:head"/></h1>
	</xsl:template>

	<!--immagini e mappa-->
	<xsl:template match="//tei:facsimile">
        <xsl:for-each select="tei:surface"> 
			<xsl:element name="img">        <!--<img src = "7694-108F.jpg" usemap = "#frontesurface1">-->
				<xsl:attribute name="src"> 
					<xsl:value-of select="current()/tei:graphic/@url"/>
				</xsl:attribute>
				<xsl:attribute name="usemap">
                    <xsl:value-of select= "concat('#',current()/@xml:id)"/> <!-- id di surface è frontesurface1, per usemap serve #frontesurface1--> 
                </xsl:attribute>
			</xsl:element>
			
				<xsl:element name="map"> <!--<map id="frontesurface1" name="frontesurface1">-->
					<xsl:attribute name="id">
						<xsl:value-of select="current()/@xml:id"/>
					</xsl:attribute>

					<xsl:attribute name="name">
						<xsl:value-of select="current()/@xml:id"/>
					</xsl:attribute>

					<xsl:for-each select="tei:zone">
					 	<xsl:element name="area"> <!--<area id="zona1.1" shape="rect" coords="10,12,345,532" href="#ID#zona1.1" alt="zona1.1" onclick="gestoreEvidenzia("zona1.1")">-->
						 	<xsl:attribute name="id"> 
                                <xsl:value-of select="current()/@xml:id"/> <!--zona1.1-->
                            </xsl:attribute>
							<xsl:attribute name="shape"> 
                                <xsl:text>rect</xsl:text>
                            </xsl:attribute>
							<xsl:attribute name="coords">
								<xsl:value-of select="@ulx"/>,<xsl:value-of select="@uly"/>,<xsl:value-of select="@lrx"/>,<xsl:value-of select="@lry"/>
							</xsl:attribute>
							<xsl:attribute name="href"> 
                                <xsl:value-of select="concat('#ID#',current()/@xml:id)"/> <!--#ID#zona1.1-->
                            </xsl:attribute>
							<xsl:attribute name="alt"> 
                                <xsl:value-of select="current()/@xml:id"/> <!--zona1.1-->
                            </xsl:attribute>
							<xsl:attribute name="onclick">
                                <xsl:value-of select="concat('gestoreEvidenzia( &quot;', @xml:id, '&quot;)' )"/>     <!-- gestoreEvidenzia("zona1.1") --> 
                            </xsl:attribute>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
		</xsl:for-each>
    </xsl:template>

	<!-- matcha qualunque elemento che abbia l'attributo facs-->
    <xsl:template match="*[@facs]"> 
        <br /><xsl:element name="a">     <!--<a name="ID#zona1.1">&#8226;&nbsp;</a>-->
            <xsl:attribute name="name">
                <xsl:value-of select="concat('ID',@facs)"/> <!--facs è #1.1-->
            </xsl:attribute>
            <xsl:text disable-output-escaping="yes"><![CDATA[&#8226;&nbsp;]]></xsl:text>  <!--puntino-->
        </xsl:element>
		<xsl:apply-templates/>
    </xsl:template>

	<!--abbreviazioni-->
	<xsl:template match="//tei:choice"> <!--<i id="gentilissima">gent.</i> vi si applica la funzione in javascript-->
		<xsl:element name="i">
            <xsl:attribute name="id">
                <xsl:value-of select="tei:expan"/>
            </xsl:attribute>
		<xsl:value-of select="tei:abbr"/>
        </xsl:element>
	</xsl:template>

	<!--template prima cartolina-->
	<xsl:template match="//tei:TEI[@xml:id='cartolina108']">
				<div>
					<!--titolo cartolina-->
					<xsl:apply-templates select="tei:text"/>
				</div>
				<!--dettagli manoscritto ed eventuali note-->
				<xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
				<div class="dettCartolina">
					<!--dettagli corrispondenza-->
					<xsl:apply-templates select="tei:teiHeader/tei:profileDesc"/>
				</div>
				<div class="dettCartolina">
					<!--lista persone e luoghi-->
					<xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson"/>
					<xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPlace"/>
				</div>
				<div class="contImmagini">
					<!--immagine e mappa-->
					<xsl:apply-templates select="tei:facsimile"/>
				</div>
				<!--stampa il testo-->
				<div class="contTesto">

					<!--fronte-->

					<!--descrizione figura-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div/tei:figure/tei:figDesc"/>
					<!--eventuale scritta sul fronte-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div[@type='fronte']/tei:div[@type='message']"/>
					

					<!--retro-->

					<!--opener-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:opener"/>
					<!--testo principale cartolina-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:div[@xml:id='body_testo']"/>
					<!--closer-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer"/>
					<!--eventuale destinazione della cartolina-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='destination']"/>
				</div>
	</xsl:template>

	<!--template seconda cartolina-->
	<xsl:template match="//tei:TEI[@xml:id='cartolina218']">
				<div>
					<!--titolo cartolina-->
					<xsl:apply-templates select="tei:text"/>
				</div>
				<!--dettagli manoscritto ed eventuali note-->
				<xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
				<div class="dettCartolina">
					<!--dettagli corrispondenza-->
					<xsl:apply-templates select="tei:teiHeader/tei:profileDesc"/>
				</div>
				<div class="dettCartolina">
					<!--lista persone e luoghi-->
					<xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson"/>
					<xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPlace"/>
				</div>
				<div class="contImmagini">
					<!--immagine e mappa-->
					<xsl:apply-templates select="tei:facsimile"/>
				</div>
				<!--stampa il testo-->
				<div class="contTesto">

					<!--fronte-->
					<!--descrizione figura-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div/tei:figure/tei:figDesc"/>
					<!--eventuale scritta sul fronte-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div[@type='fronte']/tei:div[@type='message']"/>
					

					<!--retro-->

					<!--opener-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:opener"/>
					<!--testo principale cartolina-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:div[@xml:id='body_testo']"/>
					<!--closer-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer"/>
					<!--eventuale destinazione della cartolina-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='destination']"/>
				</div>
	</xsl:template>

	<!--template terza cartolina-->
	<xsl:template match="//tei:TEI[@xml:id='cartolina182']">
				<div>
					<!--titolo cartolina-->
					<xsl:apply-templates select="tei:text"/>
				</div>
				<!--dettagli manoscritto ed eventuali note-->
				<xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
				<div class="dettCartolina">
					<!--dettagli corrispondenza-->
					<xsl:apply-templates select="tei:teiHeader/tei:profileDesc"/>
				</div>
				<div class="dettCartolina">
					<!--lista persone e luoghi-->
					<xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson"/>
					<xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPlace"/>
				</div>
				<div class="contImmagini">
					<!--immagine e mappa-->
					<xsl:apply-templates select="tei:facsimile"/>
				</div>
				<!--stampa il testo-->
				<div class="contTesto">

					<!--fronte-->

					<!--descrizione figura-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div/tei:figure/tei:figDesc"/>
					<!--eventuale scritta sul fronte-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div[@type='fronte']/tei:div[@type='message']"/>
					
					
					<!--retro-->

					<!--opener-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:opener"/>
					<!--testo principale cartolina-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:div[@xml:id='body_testo']"/>
					<!--closer-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer"/>
					<!--eventuale destinazione della cartolina-->
					<xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='destination']"/>
				</div>
	</xsl:template>

</xsl:stylesheet>