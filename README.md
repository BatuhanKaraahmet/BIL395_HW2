# BIL395_HW2
# Simple Calculator 

Bu proje, 5 farklı programlama dili ile değişken atama ve aritmetik işlemleri destekleyen hesap makinelerini içerir. Her dosya komut satırından çalışır ve kullanıcıdan aldığı ifadeleri değerlendirir.

## Özellikler
- Dört işlem: `+`, `-`, `*`, `/`
- Parantez desteği: `(1 + 2) * 3`
- Değişken atama: `x = 5 + 2`
- Değişken kullanımı: `x * 3`
- Hata yakalama: Tanımsız değişken, sıfıra bölme
- `exit` veya `quit` komutlarıyla çıkış

## Çalıştırma Talimatları

### Rust
```bash
rustc calculator.rs -o calculator
./calculator
```

### Ada
```bash
gnatmake calculator.adb
./calculator
```

### Perl
```bash
perl calculator.pl
```

### Scheme (örneğin Guile ile)
```bash
guile calculator.scm
```

### Prolog (SWI-Prolog)
```bash
swipl -s calculator.plg
?- start.
```

