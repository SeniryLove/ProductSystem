package com.example.product_application_server.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.security.Key;
import java.util.Date;

@Component
public class JwtUtil {

    @Value("${jwt.secret}")
    private String SECRET_KEY;

    @Value("${jwt.expiration}")
    private long EXPIRATION; // ms

    private Key getSigningKey() {
        return Keys.hmacShaKeyFor(SECRET_KEY.getBytes());
    }

    // 生成 JWT
    public String generateToken(Long id, String email, String nationId) {
        return Jwts.builder()
                .setSubject(id.toString())
                .claim("email", email)
                .claim("nationId", nationId)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION))
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    // 驗證 JWT 是否有效
    public boolean validateToken(String token, Long id) {
        try {
            Claims claims = extractAllClaims(token);
            return claims.getSubject().equals(id.toString()) && !isTokenExpired(claims);
        } catch (Exception e) {
            return false;
        }
    }

    private Claims extractAllClaims(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(getSigningKey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    private boolean isTokenExpired(Claims claims) {
        return claims.getExpiration().before(new Date());
    }

    public String extractId(String token) {
        return (String) extractAllClaims(token).getSubject();
    }

    public String extractEmail(String token) {
        return (String) extractAllClaims(token).get("email");
    }

    public String extractNationId(String token) {
        return (String) extractAllClaims(token).get("nationId");
    }
}