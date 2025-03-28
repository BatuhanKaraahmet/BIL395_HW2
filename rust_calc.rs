use std::collections::HashMap;
use std::io::{self, Write};
use meval::eval_str;

fn main() {
    let mut vars: HashMap<String, f64> = HashMap::new();

    loop {
        print!("> ");
        io::stdout().flush().unwrap();

        let mut input = String::new();
        io::stdin().read_line(&mut input).unwrap();
        let input = input.trim();

        if input.eq_ignore_ascii_case("exit") || input.eq_ignore_ascii_case("quit") {
            break;
        }

        if let Some(eq_pos) = input.find('=') {
            let (var, expr) = input.split_at(eq_pos);
            let var = var.trim();
            let expr = &expr[1..].trim();
            match evaluate(expr, &vars) {
                Ok(val) => {
                    vars.insert(var.to_string(), val);
                    println!("{}", val);
                }
                Err(e) => println!("Error: {}", e),
            }
        } else {
            match evaluate(input, &vars) {
                Ok(val) => println!("{}", val),
                Err(e) => println!("Error: {}", e),
            }
        }
    }
}

fn evaluate(expr: &str, vars: &HashMap<String, f64>) -> Result<f64, String> {
    let tokens: Vec<String> = expr
        .split_whitespace()
        .map(|tok| {
            if let Ok(_) = tok.parse::<f64>() {
                tok.to_string()
            } else if let Some(val) = vars.get(tok) {
                val.to_string()
            } else if "+-*/().".contains(tok) {
                tok.to_string()
            } else {
                tok.to_string()
            }
        })
        .collect();
    let final_expr = tokens.join(" ");

    match eval_str(&final_expr) {
        Ok(val) => {
            if val.is_infinite() || val.is_nan() {
                Err("Division by zero".to_string())
            } else {
                Ok(val)
            }
        }
        Err(_) => Err("Syntax error or undefined variable".to_string()),
    }
}

