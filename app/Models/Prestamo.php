<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Prestamo extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id",
        "user_desembolso_id",
        "cliente_id",
        "tipo",
        "grupo_id",
        "monto",
        "plazo",
        "f_ci",
        "f_luz",
        "f_agua",
        "croquis",
        "documento_1",
        "documento_2",
        "documento_3",
        "documento_4",
        "estado",
        "desembolso",
        "fecha_desembolso",
        "fecha_registro",
        "finalizado"
    ];

    protected $appends = ["fecha_registro_t", "fecha_desembolso_t", "sw_desembolso", "nro_pagos_realizados", "ultima_fecha_pago"];

    public function getUltimaFechaPagoAttribute()
    {
        $ultimo_plan = PlanPago::where("prestamo_id", $this->id)->orderBy("nro_cuota", "desc")->get()->first();
        if ($ultimo_plan->fecha_pago) {
            return date("d/m/Y", strtotime($ultimo_plan->fecha_pago));
        }
        return "S/D";
    }

    public function getNroPagosRealizadosAttribute()
    {
        $nro_pagos = PlanPago::where("prestamo_id", $this->id)->where("cancelado", "SI")->get();
        return count($nro_pagos);
    }

    public function getSwDesembolsoAttribute()
    {
        if ($this->fecha_desembolso) {
            $fecha_actual = date("Y-m-d");
            if ($this->fecha_desembolso == $fecha_actual) {
                return true;
            }
        }
        return false;
    }

    public function getFechaDesembolsoTAttribute()
    {
        if ($this->fecha_desembolso) {
            return date("d-m-Y", strtotime($this->fecha_desembolso));
        }
        return null;
    }

    public function getFechaRegistroTAttribute()
    {
        return date("d-m-Y", strtotime($this->fecha_registro));
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function user_desembolso()
    {
        return $this->belongsTo(User::class, 'user_desembolso_id');
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'cliente_id');
    }

    public function grupo()
    {
        return $this->belongsTo(Grupo::class, 'grupo_id');
    }

    public function plan_pagos()
    {
        return $this->hasMany(PlanPago::class, 'prestamo_id');
    }
    public function pagos()
    {
        return $this->hasMany(Pago::class, 'prestamo_id')->orderBy("id", "desc");
    }
}
