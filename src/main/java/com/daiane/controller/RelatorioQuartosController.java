package com.daiane.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;

@Controller
public class RelatorioQuartosController {
	
	@Autowired
	private DataSource ds;
	
	@GetMapping("/relatorio/quartos")
	public ModelAndView relatorioQuartosGet() {
		return new ModelAndView("quarto");
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@PostMapping("/relatorio/quartos")
	public ResponseEntity relatorioQuartosPost(@RequestParam Map<String, String> params, ModelMap model) {
		String erro = "";
		String data = params.get("data");
		
		Map<String, Object> reportParams = new HashMap<>();
		reportParams.put("P_data", java.sql.Date.valueOf(data));
		
		Connection c = DataSourceUtils.getConnection(ds);
		
		byte[] bytes = null;
		InputStreamResource resources = null;
		HttpStatus status = null;
		HttpHeaders header = new HttpHeaders();
		
		try {
			String path = "classpath:reports/RelatorioQuartos.jasper";
			File arquivo = ResourceUtils.getFile(path);
			JasperReport report = (JasperReport) JRLoader
					.loadObjectFromFile(
							arquivo.getAbsolutePath()
					);
			bytes = JasperRunManager.runReportToPdf(report, reportParams, c);
		} catch(Exception e) {
			erro = e.getMessage();
			status = HttpStatus.BAD_REQUEST;
		} finally {
			if (erro.equals("")) {
				ByteArrayInputStream stream = 
						new ByteArrayInputStream(bytes);
				resources = new InputStreamResource(stream);
				status = HttpStatus.OK;
				header.setContentLength(bytes.length);
				header.setContentType(MediaType.APPLICATION_PDF);
			}else {

				String htmlAlerta = "<script>"
						+ "alert('Nao existem quartos disponiveis na data inserida!');"
						+ "window.location.href='/Hotel/relatorio/reservas';"
						+ "</script>";
				
				ByteArrayInputStream stream = new ByteArrayInputStream(htmlAlerta.getBytes());
				resources = new InputStreamResource(stream);
				header.setContentType(MediaType.TEXT_HTML);
				header.setContentLength(htmlAlerta.getBytes().length);
			}
		}
		
		return new ResponseEntity(resources, header, status);
	}

}
